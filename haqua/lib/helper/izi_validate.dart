import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

import '../di_container.dart';

///
/// Validation
///
class IZIValidate {
  ///
  /// check password if return string is has error else null not erorr
  ///
  static String? password(String password) {
    if (password.length < 8) return 'Phải có tối thiểu 8 kí tự';
    if (!password.contains(RegExp("[a-z]"))) return 'Phải có ít nhất 1 kí tự in thường';
    if (!password.contains(RegExp("[A-Z]"))) return 'Phải có ít nhất 1 kí tự in hoa';
    if (!password.contains(RegExp("[0-9]"))) return 'Phải có ít nhất 1 số';
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'Phải có ít nhất 1 kí tự đặc biệt';
    return null;
  }

  static String? passwordHaqua(String password) {
    if (password.length < 6) return 'Phải có tối thiểu 6 kí tự';

    return null;
  }

  ///
  /// Validate email
  ///
  static String? email(String text) {
    // a-zA-Z0-9 : allow a - Z 0 -9
    // + @(Bắt buộc )
    final RegExp reg = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(text)) {
      // email hợp lệ
      return null;
    } else {
      // không hợp lệ
      return "Địa chỉ email không hợp lệ";
    }
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool phoneNumber(String? value) {
    final RegExp reg = RegExp('(0|84)(3[2-9]|5[6|8|9]|7[0|6-9]|8[0-6|8|9]|9[0-4|6-9])+([0-9]{7})');
    if (nullOrEmpty(value)) {
      return false;
    }
    if (reg.hasMatch(value!)) {
      // phone validate
      return true;
    }

    return false;
  }

  ///
  /// Validate phone
  ///
  static String? phone(String text) {
    //r'^([+0]9)?[0-9]{10}$'
    final RegExp reg = RegExp(r'^([+0])\d{9}$');
    if (reg.hasMatch(text)) {
      // phone validate
      return null;
    } else {
      // phone not validate
      return "Số điện thoại không hợp lệ";
    }
  }

  ///
  /// empty
  ///
  static String? empty(String text, {int? rangeFrom, int? rangeTo}) {
    if (text.isEmpty) {
      return "Tên không được để trống";
    }
    if (!IZIValidate.nullOrEmpty(rangeFrom)) {
      if (text.length < rangeFrom!) {
        return "Tên ít nhất phải $rangeFrom ký tự";
      }
    }
    if (!IZIValidate.nullOrEmpty(rangeTo)) {
      if (text.length > rangeTo!) {
        return "Tên không được quá $rangeFrom ký tự";
      }
    }
    return null;
  }

  ///
  /// empty
  ///
  static String? increment(String? number) {
    if (IZIValidate.nullOrEmpty(number)) {
      number = '0';
    }
    if (int.parse(number!) <= 0) {
      return "Số lượng không được bé hơn 0";
    } else if (int.parse(number) >= 999) {
      return "Số lượng không được lớn hơn 999";
    }
    return null;
  }

  ///
  /// Check nullOrEmpty
  ///
  static bool nullOrEmpty(dynamic value) {
    if (value == null || value.toString().isEmpty || value.toString() == 'null' || value.toString() == '{}' || (value is List && value.isEmpty == true)) return true;
    return false;
  }

  ///
  ///getGenderString
  ///
  static String getGenderString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'All'.tr;

    if (value == 'male') {
      return "male".tr;
    } else if (value == 'female') {
      return "Female".tr;
    } else if (value == 'all') {
      return "All".tr;
    }
    return 'All'.tr;
  }

  ///
  ///getGenderValue
  ///
  static String getGenderValue(dynamic value) {
    if (nullOrEmpty(value) == true) return 'all';

    if (value.runtimeType == String) {
      if (value.toString().contains('male'.tr)) {
        return 'male';
      } else if (value.toString().contains('Female'.tr)) {
        return 'female';
      }
      return 'all';
    }
    return 'all';
  }

  ///
  ///getGenderValueCreateQuestion
  ///
  static String getGenderValueCreateQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return 'all';

    if (value.runtimeType == String) {
      if (value.toString().contains('male'.tr)) {
        return 'male';
      } else if (value.toString().contains('Female'.tr)) {
        return 'female';
      }
      return 'all';
    }
    return 'all';
  }

  ///
  ///getRegionValueCreateQuestion
  ///
  static String getRegionValueCreateQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return 'North';

    if (value.runtimeType == String) {
      if (value.toString().toLowerCase().contains('Central'.tr)) {
        return 'Central';
      } else if (value.toString().toLowerCase().contains('South'.tr)) {
        return 'South';
      }
      return 'North';
    }
    return 'North';
  }

  ///
  ///getTypeRegisterString
  ///
  static String getTypeRegisterString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'haqua';

    if (value == 1 || value == '1') {
      return "haqua";
    } else if (value == 2 || value == '2') {
      return "google";
    } else if (value == 3 || value == '3') {
      return "apple";
    } else if (value == 4 || value == '4') {
      return "facebook";
    }
    return 'haqua';
  }

  ///
  ///getTypeStatusQuestion
  ///
  static Widget getTypeStatusQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return const Text('');

    if (value == 'connecting') {
      return Text(
        'Connecting'.tr,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.PRIMARY_APP,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (value == 'selected person') {
      return Text(
        'Selected'.tr,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.MY_QUESTION,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (value == 'called') {
      return Text(
        'Called'.tr,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.CALL_VIDEO,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (value == 'completed') {
      return Text(
        'Complete'.tr,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.PRIMARY_1,
          fontWeight: FontWeight.w600,
        ),
      );
    } else if (value == 'canceled') {
      return Text(
        'Cancelled'.tr,
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          color: ColorResources.LABEL_ORDER_HUY_DON,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    return const Text('');
  }

  ///
  ///getValueStringTypeStatusQuestion
  ///
  static String getValueStringTypeStatusQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return '';

    if (value == 'connecting') {
      return 'Connecting'.tr;
    } else if (value == 'selected person') {
      return 'Selected'.tr;
    } else if (value == 'called') {
      return 'Called'.tr;
    } else if (value == 'completed') {
      return 'Complete'.tr;
    } else if (value == 'canceled') {
      return 'Cancelled'.tr;
    }
    return '';
  }

  ///
  ///getTypeAvatarString
  ///
  String getTypeAvatarString(String value) {
    if (nullOrEmpty(value) == true) return ImagesPath.splash_haqua;

    return value;
  }

  ///
  ///genValueStringNation
  ///
  static String genValueStringNation(String value) {
    final String language = sl<SharedPreferenceHelper>().getLanguage;

    if (language == 'vi') {
      if (value == 'Anh') {
        return 'nation_English'.tr;
      }

      if (value == 'Việt Nam') {
        return 'nation_Vietnam'.tr;
      }
      if (value == 'Pháp') {
        return 'nation_France'.tr;
      }
      if (value == 'Trung Quốc') {
        return 'nation_China'.tr;
      }
      if (value == 'Hàn Quốc') {
        return 'nation_Korea'.tr;
      }

      if (value == 'Singapore') {
        return 'nation_Singapore'.tr;
      }
    }

    if (language == 'en') {
      if (value == 'England') {
        return 'nation_English'.tr;
      }

      if (value == 'Vietnam') {
        return 'nation_Vietnam'.tr;
      }
      if (value == 'France') {
        return 'nation_France'.tr;
      }
      if (value == 'China') {
        return 'nation_China'.tr;
      }
      if (value == 'Korea') {
        return 'nation_Korea'.tr;
      }

      if (value == 'Singapore') {
        return 'nation_Singapore'.tr;
      }
    }

    return 'nation_Vietnam'.tr;
  }

  ///
  /// validateSizeImages
  ///
  static bool validateSizeImages({required List<File> files}) {
    double maxSize = 0;
    for (int i = 0; i < files.length; i++) {
      final bytes = files[i].readAsBytesSync().lengthInBytes;
      maxSize += bytes / 1024 / 1024;
    }
    print('maxSize $maxSize');
    if (maxSize > 25) {
      return false;
    }

    return true;
  }
}
