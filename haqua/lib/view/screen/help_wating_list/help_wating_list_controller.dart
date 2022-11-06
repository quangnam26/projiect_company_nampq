import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/call_screen_routers.dart';
import 'package:template/routes/route_path/detail_profile_people_routers.dart';
import 'package:template/routes/route_path/review_and_payment_routers.dart';
import 'package:template/routes/route_path/share_video_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/home/home_controller.dart';
import '../../../data/datasource/remote/dio/izi_socket.dart';
import '../room_video_call/room_video_call_controller.dart';

class HelpWatingListController extends GetxController with WidgetsBindingObserver {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();
  Rx<QuestionResponse> questionResponse = QuestionResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isShowMore = false.obs;
  String? idQuestion;

  @override
  void onInit() {
    super.onInit();
    startSocket();
  }

  @override
  void onClose() {
    questionResponse.close();
    isShowMore.close();
    iziSocket.socket.off('quote_socket');
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// Start listen event socket.
      startSocket();
    }
  }

  ///
  /// Start listen event socket.
  ///
  void startSocket() {
    /// Listen quote event socket.
    if (!iziSocket.socket.hasListeners('quote_socket')) {
      iziSocket.socket.on('quote_socket', (data) {
        /// Listen quote event socket.
        listQuoteSocket(dataSocket: data);
      });
    }

    /// Get argument from before screen.
    getArgument();
  }

  ///
  /// Listen quote event socket.
  ///
  void listQuoteSocket({required dynamic dataSocket}) {
    if (!IZIValidate.nullOrEmpty(dataSocket)) {
      if (dataSocket['idAuthorQuestion'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['idQuestion'].toString() == idQuestion) {
        if (dataSocket['statusQuote'].toString() == QUOTED) {
          IZIToast().successfully(message: 'has_quote'.tr);
        } else {
          IZIToast().successfully(message: '${dataSocket['fullNameQuote'].toString()} đã từ chối báo giá');
        }

        /// Call API get data question.
        getDetailQuestionByIdResetStatus();
      }
    }
  }

  ///
  ///  Get argument from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestion = Get.arguments.toString();

      /// Call API get data question.
      getDetailQuestionById();
    }
  }

  ///
  /// Call API get data question.
  ///
  void getDetailQuestionById() {
    questionProvider.find(
      filterPopulate: "answerList.idUser",
      id: idQuestion.toString(),
      onSuccess: (model) {
        questionResponse.value = model;

        /// If status question is CALLER then go to [Review page].
        if (questionResponse.value.statusQuestion == CALLED) {

          /// If status question is CALLER then go to [Review page].
          goToReviewsPageWhenTimeUp();
        } else {

           /// Just [update] first load [Helping waiting list page].
          if (isLoading) {
            isLoading = false;
            update();
          }
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API again when back.
  ///
  void getDetailQuestionByIdResetStatus() {
    questionProvider.find(
      filterPopulate: "answerList.idUser",
      id: idQuestion.toString(),
      onSuccess: (model) {
        questionResponse.value = model;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// If status question is CALLER then go to [Review page].
  ///
  void goToReviewsPageWhenTimeUp() {
    late String idRespondent = '';
    for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
      if (questionResponse.value.answerList![i].statusSelect == SELECTED) {
        idRespondent = questionResponse.value.answerList![i].idUser!.id.toString();
      }
    }
    final Map<String, dynamic> param = {
      'idRoom': '',
      'idQuestionAsker': sl<SharedPreferenceHelper>().getIdUser,
      'idRespondent': idRespondent,
      'idQuestion': idQuestion,
    };

     /// Just [update] first load [Helping waiting list page].
    if (isLoading) {
      isLoading = false;
      update();
    }
    Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
      /// Call API again when back.
      getDetailQuestionByIdResetStatus();
    });
  }

  ///
  /// Generate value call cost.
  ///
  String genValueCallCost() {
    if (questionResponse.value.moneyTo == 0) {
      return "free".tr;
    }

    if (IZIValidate.nullOrEmpty(questionResponse.value.answerList) && questionResponse.value.moneyTo != 0) {
      return "Undefined".tr;
    }
    if (questionResponse.value.answerList!.any((element) => element.statusSelect == SELECTED) == true) {
      return "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(questionResponse.value.finalPrice))}vnđ";
    }

    return "Undefined".tr;
  }

  ///
  /// On change status show more.
  ///
  void onChangeStatusShowMore() {
    isShowMore.value = !isShowMore.value;
  }

  ///
  /// Go to [Detail profile people page].
  ///
  void goToDetailProfilePeoplePage({required String idUser, required String idAnswerer, required String statusSelect}) {
    Get.toNamed("${DetailProfilePeopleListRoutes.DETAIL_PROFILE_PROPLE}?idQuestion=$idQuestion&statusSelect=$statusSelect&statusQuestion=${questionResponse.value.statusQuestion}&idAnswerer=$idAnswerer", arguments: idUser)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        getDetailQuestionByIdResetStatus();
        IZIDialog.showDialog(
          lable: 'call_now_1'.tr,
          description: "call_now_2".tr,
          confirmLabel: "Agree".tr,
          cancelLabel: "back".tr,
          onCancel: () {
            Get.back();
          },
          onConfirm: () {
            Get.back();

            /// Go to [Call page].
            goToCallScreenPage();
          },
        );
      }
    });
  }

  ///
  /// On show dialog delete question.
  ///
  void onShowDialog() {
    IZIDialog.showDialog(
      lable: "Delete_question".tr,
      description: "content_dialog_delete".tr,
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();

        /// On delete question.
        deleteQuestion();
      },
    );
  }

  ///
  /// On delete question.
  ///
  void deleteQuestion() {
    final QuestionRequest questionRequest = QuestionRequest();
    questionRequest.statusQuestion = CANCELED;
    questionProvider.changeStatusQuestion(
      id: idQuestion.toString(),
      data: questionRequest,
      onSuccess: (model) {
        Get.find<HomeController>().getCountNotice();
        Get.back();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Go to [Call page].
  ///
  Future<void> goToCallScreenPage() async {
    /// If ios device then don't need check permission else check permission.
    if (Platform.isIOS) {
      late String idRespondent = '';
      for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
        if (questionResponse.value.answerList![i].statusSelect == SELECTED) {
          idRespondent = questionResponse.value.answerList![i].idUser!.id.toString();
        }
      }
      final Map<String, dynamic> paramSocket = {
        'idRoom': '',
        'status': CONNECT_CALL,
        'idQuestionAsker': sl<SharedPreferenceHelper>().getIdUser,
        'idRespondent': idRespondent,
        'idQuestion': idQuestion,
        'caller': QUESTION_ASKER_CALL,
      };

      /// Reload Video call controller when use more.
      Get.reload<RoomVideoCallController>();
      Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: paramSocket)!.then((value) async {
        await Future.delayed(const Duration(seconds: 2));
        sl<SharedPreferenceHelper>().setCalling(isCalling: false);

        /// Call API again when back.
        getDetailQuestionByIdResetStatus();
      });
    } else {

      /// Check speech permission.
      final statusSpeech = await Permission.speech.request();
      if (statusSpeech == PermissionStatus.granted) {
      } else if (statusSpeech == PermissionStatus.denied) {
        await openAppSettings();
      } else if (statusSpeech == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }

      /// Check camera permission.
      final statusCamera = await Permission.camera.request();
      if (statusCamera == PermissionStatus.granted) {
      } else if (statusCamera == PermissionStatus.denied) {
        await openAppSettings();
      } else if (statusCamera == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }

      if (statusSpeech == PermissionStatus.granted && statusCamera == PermissionStatus.granted) {
        late String idRespondent = '';
        for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
          if (questionResponse.value.answerList![i].statusSelect == SELECTED) {
            idRespondent = questionResponse.value.answerList![i].idUser!.id.toString();
          }
        }
        final Map<String, dynamic> paramSocket = {
          'idRoom': '',
          'status': CONNECT_CALL,
          'idQuestionAsker': sl<SharedPreferenceHelper>().getIdUser,
          'idRespondent': idRespondent,
          'idQuestion': idQuestion,
          'caller': QUESTION_ASKER_CALL,
        };

        /// Reload Video call controller when use more.
        Get.reload<RoomVideoCallController>();
        Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: paramSocket)!.then((value) async {
          await Future.delayed(const Duration(seconds: 2));
          sl<SharedPreferenceHelper>().setCalling(isCalling: false);

          /// Call API again when back.
          getDetailQuestionByIdResetStatus();
        });
      } else {
        await openAppSettings();
      }
    }
  }

  ///
  /// Show dialog complete question.
  ///
  void showDialogCompleteStatusQuestion() {
    IZIDialog.showDialog(
      lable: "comlete_ques".tr,
      description: "detail_comple_ques".tr,
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();

        /// Complete question.
        completeStatusQuestion();
      },
    );
  }

  ///
  /// Complete question.
  ///
  void completeStatusQuestion() {
    late String idRespondent = '';
    for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
      if (questionResponse.value.answerList![i].statusSelect == SELECTED) {
        idRespondent = questionResponse.value.answerList![i].idUser!.id.toString();
      }
    }
    final Map<String, dynamic> param = {
      'idRoom': '',
      'idQuestionAsker': sl<SharedPreferenceHelper>().getIdUser,
      'idRespondent': idRespondent,
      'idQuestion': idQuestion,
    };
    Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
      /// Call API again when back.
      getDetailQuestionByIdResetStatus();
    });
  }

  ///
  /// Go to [Share video page].
  ///
  void goToShareVideo() {
    Get.toNamed(ShareVideoRoutes.SHARE_VIDEO, arguments: idQuestion)!.then((value) {

      /// Call API again when back.
      getDetailQuestionByIdResetStatus();
    });
  }
}
