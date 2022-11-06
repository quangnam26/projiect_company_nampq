// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/reviews/reviews_request.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/reviews_provider.dart';
import 'package:template/routes/route_path/review_and_payment_routers.dart';
import 'package:template/utils/images_path.dart';
import '../../../di_container.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class ReviewAndPaymentController extends GetxController {
  /// Declare API.
  final ReviewsProvider reviewsProvider = GetIt.I.get<ReviewsProvider>();
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();

  /// Declare Data.
  List<Map<String, dynamic>> dataRated = [
    {
      "icon_emoji": ImagesPath.logo_satisfied,
      "icon_rated": ImagesPath.logo_selected,
    },
    {
      "icon_emoji": ImagesPath.logo_unsatisfied,
      "icon_rated": ImagesPath.logo_not_selected,
    },
  ];

  List<Map<String, dynamic>> dataConnectionQuality = [
    {
      "icon_emoji": ImagesPath.logo_satisfied,
      "icon_rated": ImagesPath.logo_selected,
    },
    {
      "icon_emoji": ImagesPath.logo_unsatisfied,
      "icon_rated": ImagesPath.logo_not_selected,
    },
  ];
  List<int> reputationList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  RxInt reputation = 10.obs;
  RxInt currentIndexSatisfied = 0.obs;
  RxInt currentIndexAgreePayment = 0.obs;
  RxDouble valueConnectionQuality = 5.0.obs;
  String? idQuestionAsker;
  String? idRespondent;
  String? idQuestion;
  RxString contentCommentController = ''.obs;
  RxString errorTextContentComment = ''.obs;
  RxString complainController = ''.obs;
  RxString errorTextComplain = ''.obs;
  bool isLoading = true;
  RxBool isSatisfied = true.obs;
  RxBool isAgreePayment = true.obs;
  RxBool isJustOneClick = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get arguments from before screen.
    getArgument();
  }

  @override
  void dispose() {
    reputation.close();
    currentIndexSatisfied.close();
    currentIndexAgreePayment.close();
    valueConnectionQuality.close();
    contentCommentController.close();
    errorTextContentComment.close();
    complainController.close();
    errorTextComplain.close();
    isSatisfied.close();
    isAgreePayment.close();
    isJustOneClick.close();
    super.dispose();
  }

  ///
  ///   Get arguments from before screen.
  ///
  void getArgument() {
    reputationList.sort();
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestionAsker = Get.arguments['idQuestionAsker'].toString();
      idRespondent = Get.arguments['idRespondent'].toString();
      idQuestion = Get.arguments['idQuestion'].toString();
    }

    isLoading = false;
    update();
  }

  ///
  /// On change reputation.
  ///
  void onChangedReputation(int val) {
    reputation.value = val;
  }

  ///
  /// On change satisfied.
  ///
  void onChangedSatisfied({required int index}) {
    currentIndexSatisfied.value = index;
    if (currentIndexSatisfied.value == 0) {
      isSatisfied.value = true;
    } else {
      isSatisfied.value = false;
    }
  }

  ///
  /// On change connection quality.
  ///
  void onChangedConnectionQuality(double val) {
    valueConnectionQuality.value = val;
  }

  ///
  /// On validate content comment.
  ///
  String onValidateContentComment(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextContentComment.value = "validate_name_1".tr;
    }

    return errorTextContentComment.value = "";
  }

  ///
  /// On change value comment.
  ///
  void onChangedValueContentComment(String val) {
    contentCommentController.value = val;
  }

  ///
  /// On validate complain.
  ///
  String onValidateComplain(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextComplain.value = "validate_name_1".tr;
    }

    return errorTextComplain.value = "";
  }

  ///
  /// On change value complain.
  ///
  void onChangedValueComplain(String val) {
    complainController.value = val;
  }

  ///
  /// On change agree payment.
  ///
  void onChangedAgreePayment({required int index}) {
    currentIndexAgreePayment.value = index;
    if (currentIndexAgreePayment.value == 0) {
      isAgreePayment.value = true;
    } else {
      isAgreePayment.value = false;
    }
  }

  ///
  /// Generate button send request.
  ///
  bool genBoolButtonSendRequest() {
    if (!IZIValidate.nullOrEmpty(contentCommentController) && isAgreePayment == true) {
      return true;
    }

    if (!IZIValidate.nullOrEmpty(contentCommentController) && isAgreePayment == false && !IZIValidate.nullOrEmpty(complainController)) {
      return true;
    }
    return false;
  }

  ///
  /// On go to [Payment successful page].
  ///
  void onGoToPaymentSuccessfulPage() {
    sl<SharedPreferenceHelper>().setCalling(isCalling: false);
    EasyLoading.show(status: "please_waiting".tr);
    if (isJustOneClick.value == false) {
      isJustOneClick.value = true;

      /// Add data review.
      final ReviewsRequest reviewsRequest = ReviewsRequest();
      reviewsRequest.idQuestion = idQuestion;
      reviewsRequest.idAuthor = idQuestionAsker;
      reviewsRequest.idAnswererRequest = idRespondent;
      reviewsRequest.reputation = reputation.value;
      reviewsRequest.isSatisfied = isSatisfied.value;
      reviewsRequest.rating = valueConnectionQuality.value;
      reviewsRequest.content = contentCommentController.value;
      reviewsRequest.isAgreePay = isAgreePayment.value;
      if (isAgreePayment.value == false) {
        reviewsRequest.complain = complainController.value;
      }
      reviewsProvider.add(
        data: reviewsRequest,
        onSuccess: (model) {
          questionProvider.changeStatusEndCall(
            id: idQuestion.toString(),
            onSuccess: (val) {
              final QuestionRequest questionRequestUpdate = QuestionRequest();
              questionRequestUpdate.comment = contentCommentController.value;
              if (isAgreePayment.value == false) {
                questionRequestUpdate.denounce = complainController.value;
              }
              questionProvider.update(
                id: idQuestion.toString(),
                data: questionRequestUpdate,
                onSuccess: (val) {
                  isJustOneClick.value = false;
                  EasyLoading.dismiss();
                  if (isAgreePayment.value == true) {
                    Get.toNamed(ReviewAndPaymentRoutes.PAYMENT_SUCCESSFUL_ASKER, arguments: idQuestion);
                  } else {
                    Get.toNamed(ReviewAndPaymentRoutes.COMPLAINT_SUCCESSFUL);
                  }
                },
                onError: (error) {
                  print(error);
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }
}
