import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../di_container.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class ChangeLanguageController extends GetxController {
  //Khai bao data
  final List<Map<String, dynamic>> localeList = [
    {
      'name': 'vietnamese'.tr,
      'locale': const Locale('vi', 'VN'),
    },
    {
      'name': 'english'.tr,
      'locale': const Locale('en', 'US'),
    },
  ];
  String? locale;
  int vietNamLanguageValue = 1;
  int englishLanguageValue = 2;
  int groupValueLanguage = 1;
  bool isLoading = true;

  @override
  void onInit() {
    initValueLanguage();
    super.onInit();
  }

  ///
  /// initValueLanguage
  ///
  void initValueLanguage() {
    final String language = sl<SharedPreferenceHelper>().getLanguage;
    if (language == 'vi' || language == 'vi_VN') {
      groupValueLanguage = vietNamLanguageValue;
    } else {
      groupValueLanguage = englishLanguageValue;
    }
    isLoading = false;
    update();
  }

  ///
  /// onChangeRadioButton
  ///
  void onChangeRadioButton({required int val}) {
    if (val == 1) {
      sl<SharedPreferenceHelper>().setLanguage('vi');
      Get.updateLocale(const Locale('vi', 'VN'));
    } else {
      sl<SharedPreferenceHelper>().setLanguage('en');
      Get.updateLocale(const Locale('en', 'US'));
    }
    groupValueLanguage = val;
    update();
  }
}
