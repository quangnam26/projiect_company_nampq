// ignore_for_file: use_setters_to_change_properties, invalid_use_of_protected_member

import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:izi_izi_checkbox_grouped/checkbox_grouped.dart';
import 'package:template/data/model/specialize_and_%20sub_specialize/specialize_and_%20sub_specialize_response.dart';
import 'package:template/data/model/userspecialize/userspecialize_request.dart';
import 'package:template/data/model/userspecialize/userspecialize_responsi.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/specialize_provider.dart';
import 'package:template/provider/userspecialize_provider.dart';
import 'package:template/routes/route_path/thank_you_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class AreasOfExpertiseController extends GetxController {
  /// Declare API.
  final SpecializeProvider specializeProvider = GetIt.I.get<SpecializeProvider>();
  final UserSpecializeProvider userSpecializeProvider = GetIt.I.get<UserSpecializeProvider>();
  Rx<UserSpecializeResponse> userSpecializeResponse = UserSpecializeResponse().obs;
  RxList<SpecializeAndSubSpecializeResponse> specializeAndSubSpecializeResponseList = <SpecializeAndSubSpecializeResponse>[].obs;
  RxList<SpecializeAndSubSpecializeResponse> specializeAndSubSpecializeResponseListMapping = <SpecializeAndSubSpecializeResponse>[].obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isCheckedOther = false.obs;
  RxBool isEnableButton = true.obs;
  List<dynamic> idSubSpecializesList = [];
  String? typeRegister;
  RxString helpYou = ''.obs;
  RxString suggestedTopic = ''.obs;
  RxString initHelpYou = ''.obs;
  RxString initSuggestedTopic = ''.obs;
  List<GroupController>? multipleCheckControllerList;
  List<void> onChangedSimpleGroupedCheckbox = [];

  @override
  void onInit() {
    super.onInit();

    /// Get Argument from before screen.
    _getArguments();
  }

  @override
  void onClose() {
    userSpecializeResponse.close();
    specializeAndSubSpecializeResponseList.close();
    specializeAndSubSpecializeResponseListMapping.close();
    isCheckedOther.close();
    isEnableButton.close();
    helpYou.close();
    suggestedTopic.close();
    initHelpYou.close();
    initSuggestedTopic.close();
    multipleCheckControllerList!.clear();
    super.onClose();
  }

  ///
  /// Get Argument from before screen.
  ///
  void _getArguments() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      typeRegister = Get.arguments as String;
    }

    /// Get data specializes and subSpecializes.
    _getDataSpecializeAndSubSpecializeResponse();
  }

  ///
  /// Get data specializes and subSpecializes.
  ///
  void _getDataSpecializeAndSubSpecializeResponse() {
    specializeProvider.paginateSpecializesAndSubSpecializes(
      onSuccess: (models) {
        specializeAndSubSpecializeResponseList.value = models;

        /// If typeRegister == 1 the get data specialize of user else binding group controller.
        if (typeRegister == '1') {
          _getDataUserSpec();
        } else {
          _binDingGroupController();
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Get data specialize of user.
  ///
  void _getDataUserSpec() {
    userSpecializeProvider.paginate(
      page: 1,
      limit: 1,
      filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
      onSuccess: (models) {
        userSpecializeResponse.value = models.first;

        /// Get data specialize of user and mapping to view.
        if (!IZIValidate.nullOrEmpty(userSpecializeResponse.value.helpYou) || !IZIValidate.nullOrEmpty(userSpecializeResponse.value.suggestedTopic)) {
          isCheckedOther.value = true;
        }
        if (!IZIValidate.nullOrEmpty(userSpecializeResponse.value.helpYou)) {
          helpYou.value = userSpecializeResponse.value.helpYou.toString();
          initHelpYou.value = userSpecializeResponse.value.helpYou.toString();
        }
        if (!IZIValidate.nullOrEmpty(userSpecializeResponse.value.suggestedTopic)) {
          suggestedTopic.value = userSpecializeResponse.value.suggestedTopic.toString();
          initSuggestedTopic.value = userSpecializeResponse.value.suggestedTopic.toString();
        }

        /// Get data sub specialize from user.
        getDataSubSpeFromUser();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Get data sub specialize from user.
  ///
  void getDataSubSpeFromUser() {
    specializeProvider.getSpecializesAndSubSpecializesMapping(
      idUserSubSpecialize: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (models) {
        /// Mapping from data and reversed data.
        specializeAndSubSpecializeResponseListMapping.value = List.from(models.reversed);

        /// Binding group controller.
        _binDingGroupController();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Binding group controller.
  ///
  void _binDingGroupController() {
    /// If type registered == 1 then mapping data view from data user else binding data to select.
    if (typeRegister == '1') {
      multipleCheckControllerList = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => GroupController(
          isMultipleSelection: true,
          initSelectedItem: specializeAndSubSpecializeResponseListMapping[index].subSpecializes!.map((e) => e.id.toString()).toList(),
          // initSelectedItem: specializeAndSubSpecializeResponseList[index].subSpecializes!.map((e) => e.id.toString()).toList(),
        ),
      );
      idSubSpecializesList = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => specializeAndSubSpecializeResponseListMapping[index].subSpecializes!.map((e) => e.id.toString()).toList(),
      );
      onChangedSimpleGroupedCheckbox = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => (dynamic val) {
          idSubSpecializesList[index] = val;
          update();
        },
      );
    } else {
      multipleCheckControllerList = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => GroupController(
          isMultipleSelection: true,
        ),
      );
      idSubSpecializesList = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => "",
      );
      onChangedSimpleGroupedCheckbox = List.generate(
        specializeAndSubSpecializeResponseList.length,
        (index) => (dynamic val) {
          idSubSpecializesList[index] = val;
          update();
        },
      );
    }

    /// Just [update] first load [Areas of expertise page].
    if (isLoading) {
      isLoading = false;
      update();
    }
  }

  ///
  /// On changed value check box.
  ///
  void onChangedChecked(bool val) {
    isCheckedOther.value = val;
    if (isCheckedOther.value == false) {
      helpYou.value = '';
      suggestedTopic.value = '';
    }
  }

  ///
  /// On change value help you import.
  ///
  void onChangedHelpYou(String val) {
    helpYou.value = val;
  }

  ///
  /// On change value topic import.
  ///
  void onChangedSuggestedTopic(String val) {
    suggestedTopic.value = val;
  }

  ///
  /// Generate value enable button.
  ///
  bool genEnableButton() {
    if (idSubSpecializesList.every((e) => e.toString().length < 24) == true) {
      return false;
    }

    return true;
  }

  ///
  /// Go to [Thank you page].
  ///
  void goToThankYouPage() {
    isEnableButton.value = false;
    EasyLoading.show(status: "Please waiting...");

    final List<String> idSubSpecializesListRequest = [];
    final idList = json.encode(idSubSpecializesList);
    final List<String> idSubSpecializeListString = idList.replaceAllMapped('"', (match) => '').replaceAllMapped(']', (match) => '').replaceAllMapped('[', (match) => '').removeAllWhitespace.trim().split(',');
    for (var i = 0; i < idSubSpecializeListString.length; i++) {
      if (idSubSpecializeListString[i].length == 24) {
        idSubSpecializesListRequest.add(idSubSpecializeListString[i]);
      }
    }

    final UserSpecializeRequest userSpecializeRequest = UserSpecializeRequest();
    userSpecializeRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
    userSpecializeRequest.idSubSpecializes = idSubSpecializesListRequest;
    if (isCheckedOther.value == true) {
      if (!IZIValidate.nullOrEmpty(helpYou)) {
        userSpecializeRequest.helpYou = helpYou.value;
      }
      if (!IZIValidate.nullOrEmpty(suggestedTopic)) {
        userSpecializeRequest.suggestedTopic = suggestedTopic.value;
      }
    }

    /// If typeRegister is 1 then update user specializes else add user specializes.
    if (typeRegister == '1') {
      userSpecializeProvider.update(
        id: userSpecializeResponse.value.id.toString(),
        data: userSpecializeRequest,
        onSuccess: (models) {
          EasyLoading.dismiss();
          Get.back();
        },
        onError: (error) {
          EasyLoading.dismiss();
          print(error);
        },
      );
    } else {
      userSpecializeProvider.add(
        data: userSpecializeRequest,
        onSuccess: (models) {
          EasyLoading.dismiss();
          Get.offAllNamed(ThankYouRoutes.THANK_YOU);
        },
        onError: (error) {
          EasyLoading.dismiss();
          print(error);
        },
      );
    }
  }
}
