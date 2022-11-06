import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/reviews/reviews_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/reviews_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/izi_preview_image_routers.dart';
import 'package:template/routes/route_path/payment_for_people_answer_ques_routers.dart';
import '../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_number.dart';
import '../../../provider/history_quiz_provider.dart';
import '../../../provider/settings_provider.dart';

class DetailProfilePeopleController extends GetxController {
  ///
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ReviewsProvider reviewProvider = GetIt.I.get<ReviewsProvider>();
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final SettingsProvider settingProvider = GetIt.I.get<SettingsProvider>();
  final HistoryQuizProvider historyQuizProvider = GetIt.I.get<HistoryQuizProvider>();
  RxList<ReviewsResponse> reviewsResponseList = <ReviewsResponse>[].obs;
  Rx<UserResponse> userResponse = UserResponse().obs;
  RxList<HistoryQuizResponse> historyQuizResponseList = <HistoryQuizResponse>[].obs;

  /// Declare Data.
  RxInt currentIndex = 0.obs;
  String? idUser;
  String? idQuestion;
  String? idAnswerer;
  RxString statusQuestion = ''.obs;
  RxString statusSelect = ''.obs;
  bool isLoading = true;
  PageController pageController = PageController();
  ScrollController controllerItemAvatar = ScrollController();
  double quizPercent = 0;

  @override
  void onInit() {
    /// Call API get quiz percent .
    getQuizPercent();
    super.onInit();
  }

  @override
  void dispose() {
    statusSelect.close();
    statusQuestion.close();
    currentIndex.close();
    pageController.dispose();
    controllerItemAvatar.dispose();
    historyQuizResponseList.close();
    super.dispose();
  }

  ///
  /// Call API get quiz percent .
  ///
  void getQuizPercent() {
    settingProvider.findSetting(
      onSuccess: (model) {
        if (!IZIValidate.nullOrEmpty(model)) {
          quizPercent = IZINumber.parseDouble(model!.quizPassPercent.toString());
        }

        /// Get the from before screen.
        getArgument();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Get the from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idUser = Get.arguments.toString();
    }

    if (!IZIValidate.nullOrEmpty(Get.parameters['idQuestion'])) {
      idQuestion = Get.parameters['idQuestion'].toString();
    }

    if (!IZIValidate.nullOrEmpty(Get.parameters['idAnswerer'])) {
      idAnswerer = Get.parameters['idAnswerer'].toString();
    }

    if (!IZIValidate.nullOrEmpty(Get.parameters['statusSelect'])) {
      statusSelect.value = Get.parameters['statusSelect'].toString();
    }
    if (!IZIValidate.nullOrEmpty(Get.parameters['statusQuestion'])) {
      statusQuestion.value = Get.parameters['statusQuestion'].toString();
    }

    /// Call API get data user.
    getInfoUser();
  }

  ///
  /// Call API get data user.
  ///
  void getInfoUser() {
    userProvider.find(
      id: "${idUser.toString()}?populate=idProvince",
      onSuccess: (model) {
        userResponse.value = model;

        ///  Call API get data reviews.
        getDataReviews();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///  Call API get data reviews.
  ///
  void getDataReviews() {
    reviewProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&idAnswerer=$idUser&isAgreePay=true&populate=idAnswerer",
      onSuccess: (models) {
        reviewsResponseList.value = models;

        /// Call API get certificates.
        getCertificates();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get certificates.
  ///
  void getCertificates() {
    print('&idUser=${idUser.toString()}&percent>=$quizPercent&populate=idCertificate');
    historyQuizProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idUser=${idUser.toString()}&percent>=$quizPercent&populate=idCertificate',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          historyQuizResponseList.value = models;
        }

        /// Just [update] first load [Detail profile people page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// Generate value address.
  ///
  String genStringAddress(String? address, ProvinceResponse? province, String? nation) {
    if (!IZIValidate.nullOrEmpty(address) && !IZIValidate.nullOrEmpty(province) && !IZIValidate.nullOrEmpty(nation)) {
      return "$address, ${province!.name.toString()}, $nation";
    }
    if (!IZIValidate.nullOrEmpty(address) && IZIValidate.nullOrEmpty(province) && IZIValidate.nullOrEmpty(nation)) {
      return address.toString();
    }

    if (IZIValidate.nullOrEmpty(address) && !IZIValidate.nullOrEmpty(province) && !IZIValidate.nullOrEmpty(nation)) {
      return "${province!.name.toString()}, $nation";
    }
    if (IZIValidate.nullOrEmpty(address) && IZIValidate.nullOrEmpty(province) && !IZIValidate.nullOrEmpty(nation)) {
      return nation.toString();
    }
    if (!IZIValidate.nullOrEmpty(address) && !IZIValidate.nullOrEmpty(province) && IZIValidate.nullOrEmpty(nation)) {
      return "$address, ${province!.name.toString()}";
    }
    if (IZIValidate.nullOrEmpty(address) && !IZIValidate.nullOrEmpty(province) && !IZIValidate.nullOrEmpty(nation)) {
      return "${province!.name.toString()}, $nation";
    }
    if (!IZIValidate.nullOrEmpty(address) && IZIValidate.nullOrEmpty(province) && !IZIValidate.nullOrEmpty(nation)) {
      return "$address, $nation";
    }

    if (IZIValidate.nullOrEmpty(address) && !IZIValidate.nullOrEmpty(province) && IZIValidate.nullOrEmpty(nation)) {
      return province!.name.toString();
    }

    return "Not_updated_yet".tr;
  }

  ///
  /// On click to scroll avatar.
  ///
  void clickToAvatar({required int index}) {
    currentIndex.value = index;
    final double positionAvatar = index * IZIDimensions.iziSize.width;
    final double positionItemAvatar = index * (IZIDimensions.iziSize.width * .2);
    pageController.animateTo(positionAvatar, duration: const Duration(milliseconds: 600), curve: Curves.ease);
    controllerItemAvatar.animateTo(positionItemAvatar, duration: const Duration(milliseconds: 600), curve: Curves.ease);
  }

  ///
  /// On change page view.
  ///
  void onPageChanged({required int index}) {
    currentIndex.value = index;
    final double positionItemAvatar = index * (IZIDimensions.iziSize.width * .2);
    controllerItemAvatar.animateTo(positionItemAvatar, duration: const Duration(milliseconds: 600), curve: Curves.ease);
  }

  ///
  /// On go to [Preview image page].
  ///
  void onGoToPreviewImage({required String urlImage}) {
    Get.toNamed(IZIPreviewImageRoutes.IZI_PREVIEW_IMAGE, arguments: urlImage);
  }

  ///
  /// On show selected account dialog.
  ///
  void onShowDialog() {
    IZIDialog.showDialog(
      lable: "Select_account_quote".tr,
      description: "validate_choose_account".tr,
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        selectAnswerer();
      },
    );
  }

  ///
  /// On selected answer.
  ///
  void selectAnswerer() {
    questionProvider.selectAnswerer(
      idQuestion: idQuestion.toString(),
      idUser: idUser.toString(),
      data: QuestionRequest(),
      onSuccess: (models) {
        Get.back(result: true);
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// On go to [Payment for people answer page].
  ///
  void goToPaymentForPeopleAnswerQuesPage() {
    Get.toNamed(PaymentForPeppleAnswerQuesListRoutes.PAYMENT_FOR_PEOPLE_ANSWER_QUES);
  }
}
