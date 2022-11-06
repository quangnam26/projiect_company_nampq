import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/call_screen_routers.dart';
import 'package:template/routes/route_path/detail_profile_people_routers.dart';
import 'package:template/routes/route_path/quotation_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../data/datasource/remote/dio/izi_socket.dart';
import '../../../../data/model/user/user_response.dart';
import '../../../../provider/user_provider.dart';
import '../../room_video_call/room_video_call_controller.dart';

class DetailQuotationController extends GetxController {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  Rx<QuestionResponse> questionResponse = QuestionResponse().obs;
  Rx<UserResponse> userResponse = UserResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  String? idQuestion;

  @override
  void onInit() {
    super.onInit();

    /// Get arguments from before screen.
    getArgument();
  }

  @override
  void dispose() {
    questionResponse.close();
    userResponse.close();
    super.dispose();
  }

  ///
  /// Get arguments from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestion = Get.arguments.toString();
    }

    /// Call API get data question by id.
    getDetailQuestionById();
  }

  ///
  /// Call API get data question by id.
  ///
  void getDetailQuestionById() {
    questionProvider.find(
      filterPopulate: "idUser.idProvince,answerList.idUser",
      id: idQuestion.toString(),
      onSuccess: (model) {
        questionResponse.value = model;

        /// Call API get data user.
        getUserById();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data user.
  ///
  void getUserById() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse.value = model;

        /// Just [update] first load [Detail quotation page].
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
  /// Generate cost quoted.
  ///
  String genCostQuoted() {
    String costQuoted = "0";
    for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
      if (questionResponse.value.answerList![i].idUserString.toString() == sl<SharedPreferenceHelper>().getIdUser) {
        costQuoted = questionResponse.value.answerList![i].price.toString();
        break;
      }
    }
    return costQuoted;
  }

  ///
  /// Format second to minutes.
  ///
  String formatSecondToMinutes(int seconds) {
    return '${const Duration(seconds: 1000).inMinutes}';
  }

  ///
  /// Generate status button.
  ///
  bool genBoolStatusButton() {
    for (int i = 0; i < questionResponse.value.answerList!.length; i++) {
      if (questionResponse.value.answerList![i].idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser) {
        if (questionResponse.value.answerList![i].statusSelect == WAITING) {
          return false;
        }
        if (questionResponse.value.answerList![i].statusSelect == SELECTED) {
          return true;
        }
      }
    }
    return false;
  }

  ///
  /// Generate status selected.
  ///
  Widget genStatusSelected() {
    if (questionResponse.value.answerList![questionResponse.value.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == FAILURE && questionResponse.value.statusQuestion == COMPLETED) {
      return Text(
        'Complete'.tr,
        style: TextStyle(
          color: ColorResources.CALL_VIDEO,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (questionResponse.value.answerList![questionResponse.value.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == FAILURE) {
      return Text(
        'refuse'.tr,
        style: TextStyle(
          color: ColorResources.RED,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (questionResponse.value.answerList![questionResponse.value.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == SELECTED) {
      return Text(
        'selected_answer_list'.tr,
        style: TextStyle(
          color: ColorResources.LABEL_ORDER_DA_GIAO,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Text(
      'đang_cho'.tr,
      style: TextStyle(
        color: ColorResources.PRIMARY_APP,
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ///
  /// Gen value string address.
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
  /// Go to [Call page].
  ///
  Future<void> goToCallScreenPage() async {
    ///
    /// If ios device then don't need check permission else check permission.
    if (Platform.isIOS) {
      final Map<String, dynamic> paramSocket = {
        'idRoom': '',
        'status': CONNECT_CALL,
        'idQuestionAsker': questionResponse.value.idUser!.id.toString(),
        'idRespondent': sl<SharedPreferenceHelper>().getIdUser,
        'idQuestion': idQuestion,
        'caller': RESPONDENT_CALL,
      };

      /// Reload [Room video call controller] controller when used multiple times.
      Get.reload<RoomVideoCallController>();
      Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: paramSocket)!.then((value) async {
        await Future.delayed(const Duration(seconds: 2));
        sl<SharedPreferenceHelper>().setCalling(isCalling: false);
        getDetailQuestionById();
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
        final Map<String, dynamic> paramSocket = {
          'idRoom': '',
          'status': CONNECT_CALL,
          'idQuestionAsker': questionResponse.value.idUser!.id.toString(),
          'idRespondent': sl<SharedPreferenceHelper>().getIdUser,
          'idQuestion': idQuestion,
          'caller': RESPONDENT_CALL,
        };

        /// Reload [Room video call controller] controller when used multiple times.
        Get.reload<RoomVideoCallController>();
        Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: paramSocket)!.then((value) async {
          await Future.delayed(const Duration(seconds: 2));
          sl<SharedPreferenceHelper>().setCalling(isCalling: false);
          getDetailQuestionById();
        });
      }
    }
  }

  /// On go to [View profile user create question page].
  ///
  void onGoToViewProfileUserCreateQues({required String idUser}) {
    Get.toNamed(DetailProfilePeopleListRoutes.VIEW_PROFILE_USER_CREATED_QUES, arguments: idUser);
  }

  ///
  /// Delete user answer list.
  ///
  void deleteUserInAnswerList() {
    EasyLoading.show(status: "please_waiting".tr);
    questionProvider.deleteUserInAnswerList(
      idQuestion: idQuestion.toString(),
      idUser: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {

        final Map<String, dynamic> paramSocket = {
          'idAuthorQuestion': questionResponse.value.idUser!.id.toString(),
          'idQuestion': idQuestion,
          'statusQuote': QUOTED_CANCELED,
          'fullNameQuote': userResponse.value.fullName.toString(),
        };

        /// Shoot the socket for the helping waiting list page.
        iziSocket.socket.emit('quote_socket', paramSocket);

        EasyLoading.dismiss();
        Get.back();
      },
      onError: (error) {
        EasyLoading.dismiss();
        print(error);
      },
    );
  }

  ///
  /// Go to [Share page].
  ///
  void goToShareScreen({required String idQuestion}) {
    Get.toNamed(QuotationRoutes.REQUESTSHARE, arguments: idQuestion);
  }
}
