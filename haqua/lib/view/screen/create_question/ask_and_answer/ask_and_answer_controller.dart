// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/upload_files/upload_files_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/upload_files_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/routes/route_path/payment_for_people_answer_ques_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/home/home_controller.dart';

class AskAndAnswerController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final UploadFilesProvider uploadFilesProvider = GetIt.I.get<UploadFilesProvider>();
  QuestionRequest questionRequest = QuestionRequest();
  UserResponse userResponse = UserResponse();

  /// Declare Data.
  bool isLoading = true;
  RxBool isRechargeMoneyToPayMentQuestion = false.obs;
  RxBool isFirstValidateLanguage = false.obs;
  RxBool isFirstValidateGender = false.obs;
  RxBool isFirstValidateRegion = false.obs;
  RxBool isEnableButton = true.obs;
  RxBool isJustOneClick = false.obs;
  RxString isSelectedLanguageCreateQuestion = ''.obs;
  RxString isSelectedGenderCreateQuestion = ''.obs;
  RxString isSelectedRegionCreateQuestion = ''.obs;
  RxString priorityLanguage = ''.obs;
  RxString valueGenderCreateQuestion = ''.obs;
  RxString valueRegionCreateQuestion = ''.obs;
  RxInt priorityGender = 0.obs;
  RxInt priorityRegion = 0.obs;

  /// ignore: non_constant_identifier_names
  RxList<Map<String, dynamic>> DATA_CREATE_QUESTION_ASK_AND_ANSWER = <Map<String, dynamic>>[
    {
      "id": 0,
      "name": 'experience'.tr,
      "isSelected": false,
    },
    {
      "id": 1,
      "name": 'experts'.tr,
      "isSelected": false,
    },
    {
      "id": 2,
      "name": 'high_rating'.tr,
      "isSelected": false,
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();

    /// Get argument from before screen.
    getArgument();
  }

  ///
  /// Get argument from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      questionRequest = Get.arguments as QuestionRequest;
    }

    /// Call API get data info user.
    getInfoUser();
  }

  ///
  /// Call API get data info user.
  ///
  void getInfoUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse = model;
        if (userResponse.defaultAccount! < questionRequest.moneyTo!) {
          isRechargeMoneyToPayMentQuestion.value = true;
        }

        /// Just [update] first load [Ask and Answer page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// On change language.
  ///
  void onChangedLanguage({required String val}) {
    isSelectedLanguageCreateQuestion.value = val;
  }

  ///
  /// On change gender.
  ///
  void onChangedGender({required String val}) {
    isSelectedGenderCreateQuestion.value = val;
    valueGenderCreateQuestion.value = IZIValidate.getGenderValueCreateQuestion(isSelectedGenderCreateQuestion.value.toString());
  }

  ///
  /// On change region.
  ///
  void onChangedRegion({required String val}) {
    isSelectedRegionCreateQuestion.value = val;
    valueRegionCreateQuestion.value = IZIValidate.getRegionValueCreateQuestion(isSelectedRegionCreateQuestion.value.toString());
  }

  ///
  /// On change selected.
  ///
  void onSelected({required int index, required bool val}) {
    DATA_CREATE_QUESTION_ASK_AND_ANSWER[index]['isSelected'] = val;
    update();
  }

  ///
  /// On create question.
  ///
  void onCreateQuestion() {
    /// Validate data when create question.
    if (IZIValidate.nullOrEmpty(isSelectedLanguageCreateQuestion.value)) {
      isFirstValidateLanguage.value = true;
    } else if (IZIValidate.nullOrEmpty(isSelectedGenderCreateQuestion.value)) {
      isFirstValidateGender.value = true;
    } else if (IZIValidate.nullOrEmpty(isSelectedRegionCreateQuestion.value)) {
      isFirstValidateRegion.value = true;
    } else {
      /// Loop DATA_CREATE_QUESTION_ASK_AND_ANSWER to set value for data question.
      questionRequest.priorityLanguage = isSelectedLanguageCreateQuestion.value;
      questionRequest.priorityGender = IZIValidate.getGenderValueCreateQuestion(isSelectedGenderCreateQuestion.value);
      questionRequest.priorityRegion = IZIValidate.getRegionValueCreateQuestion(isSelectedRegionCreateQuestion.value);
      for (var i = 0; i < DATA_CREATE_QUESTION_ASK_AND_ANSWER.length; i++) {
        if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['isSelected'] == true) {
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 0) {
            questionRequest.priorityExperience = PRIORITY;
          }
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 1) {
            questionRequest.priorityExpert = PRIORITY;
          }
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 2) {
            questionRequest.priorityRank = PRIORITY;
          }
        } else {
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 0) {
            questionRequest.priorityExperience = NOT_PRIORITY;
          }
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 1) {
            questionRequest.priorityExpert = NOT_PRIORITY;
          }
          if (DATA_CREATE_QUESTION_ASK_AND_ANSWER[i]['id'] == 2) {
            questionRequest.priorityRank = NOT_PRIORITY;
          }
        }
      }

      /// If not enough money then show recharge money dialog else create question.
      if (isRechargeMoneyToPayMentQuestion.value == true) {
        onShowDialog();
      } else {
        /// Confirm files upload before create question.
        confirmUrlFilesBeforeCreateQuestion();
      }
    }
  }

  ///
  /// Confirm files upload before create question.
  ///
  Future<void> confirmUrlFilesBeforeCreateQuestion() async {
    if (isJustOneClick.value == false) {
      isJustOneClick.value = true;
      EasyLoading.show(status: "please_waiting".tr);
      isEnableButton.value = false;
      if (!IZIValidate.nullOrEmpty(questionRequest.attachImages) && !IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {
        final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
        uploadImagesRequest.files = questionRequest.attachImages;
        uploadFilesProvider.confirmUploadFiles(
          data: uploadImagesRequest,
          onSuccess: (values) {
            questionRequest.attachImages!.clear();

            questionRequest.attachImages = values.map((e) => e.files!.first.toString()).toList();

            final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
            uploadFilesRequest.files = questionRequest.attachFiles;
            uploadFilesProvider.confirmUploadFiles(
              data: uploadFilesRequest,
              onSuccess: (values) {
                questionRequest.attachFiles!.clear();

                questionRequest.attachFiles = values.map((e) => e.files!.first.toString()).toList();

                /// Create question.
                addQuestion();
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
      } else if (!IZIValidate.nullOrEmpty(questionRequest.attachImages) && IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {

        final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
        uploadImagesRequest.files = questionRequest.attachImages;
        uploadFilesProvider.confirmUploadFiles(
          data: uploadImagesRequest,
          onSuccess: (values) {
            questionRequest.attachImages!.clear();

            questionRequest.attachImages = values.map((e) => e.files!.first.toString()).toList();

            /// Create question.
            addQuestion();
          },
          onError: (error) {
            print(error);
          },
        );
      } else if (IZIValidate.nullOrEmpty(questionRequest.attachImages) && !IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {

        final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
        uploadFilesRequest.files = questionRequest.attachFiles;
        uploadFilesProvider.confirmUploadFiles(
          data: uploadFilesRequest,
          onSuccess: (values) {
            questionRequest.attachFiles!.clear();

            questionRequest.attachFiles = values.map((e) => e.files!.first.toString()).toList();

            /// Create question.
            addQuestion();
          },
          onError: (error) {
            print(error);
          },
        );
      } else {
        /// Create question.
        addQuestion();
      }
    }
  }

  ///
  /// Create question.
  ///
  void addQuestion() {
    questionProvider.add(
      data: questionRequest,
      onSuccess: (model) {
        final QuestionRequest questionRequestChangeStatusPayment = QuestionRequest();
        questionRequestChangeStatusPayment.statusPayment = DEPOSITED;
        questionProvider.changeStatusPayment(
          id: model.id.toString(),
          data: questionRequestChangeStatusPayment,
          onSuccess: (models) {
            isJustOneClick.value = false;
            EasyLoading.dismiss();
            IZIToast().successfully(message: 'create_ques_succes'.tr);
            Get.find<HomeController>().getCountNotice();
            Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
          },
          onError: (onError) {
            print(onError);
          },
        );
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// On Show recharge money dialog.
  ///
  void onShowDialog() {
    IZIDialog.showDialog(
      lable: "recharge".tr,
      description: "${'The_amount_in_your_wallet_is'.tr}${IZIPrice.currencyConverterVND(IZINumber.parseDouble(userResponse.defaultAccount))}VNĐ. ${'Please_add_more_money_to_continue'.tr}",
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        Get.toNamed("${PaymentForPeppleAnswerQuesListRoutes.PAYMENT_FOR_PEOPLE_ANSWER_QUES}?typeRecharge=1", arguments: questionRequest);
      },
    );
  }
}
