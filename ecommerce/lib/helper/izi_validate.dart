// ignore: avoid_classes_with_only_static_members
///
/// Validation
///
// ignore_for_file: parameter_assignments

class IZIValidate {
  ///
  /// check password if return string is has error else null not erorr
  ///
  static String? password(String password) {
    // if (password.length < 8) return 'Phải có tối thiểu 8 kí tự';
    // if (!password.contains(RegExp("[a-z]")))
    //   return 'Phải có ít nhất 1 kí tự in thường';
    // if (!password.contains(RegExp("[A-Z]")))
    //   return 'Phải có ít nhất 1 kí tự in hoa';
    // if (!password.contains(RegExp("[0-9]"))) return 'Phải có ít nhất 1 số';
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')))
    //   return 'Phải có ít nhất 1 kí tự đặc biệt';
    if (password.length < 6) return 'Phải có tối thiểu 6 kí tự';
    // if (!password.contains(RegExp("[a-z]"))) return 'Phải có ít nhất 1 kí tự in thường';
    // if (!password.contains(RegExp("[A-Z]"))) return 'Phải có ít nhất 1 kí tự in hoa';
    // if (!password.contains(RegExp("[0-9]"))) return 'Phải có ít nhất 1 số';
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return 'Phải có ít nhất 1 kí tự đặc biệt';
    return null;
  }

  ///
  /// Validate email
  ///
  static String? email(String text) {
    // a-zA-Z0-9 : allow a - Z 0 -9
    // + @(Bắt buộc )
    final RegExp reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(text)) {
      // email hợp lệ
      return null;
    } else {
      // không hợp lệ
      return "Địa chỉ email không hợp lệ";
    }
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
    if (value == null ||
        value.toString().isEmpty ||
        value.toString() == 'null' ||
        value.toString() == '{}' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  static String getGenderString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'Không xác định';

    if (value == 1 || value == '1') {
      return "Nam";
    } else if (value == 2 || value == '2') {
      return "Nữ";
    } else if (value == 2 || value == '3') {
      return "Tất cả";
    }
    return 'Không xác định';
  }

  static String getGenderValue(dynamic value) {
    if (nullOrEmpty(value) == true) return '3';

    if (value.runtimeType == String) {
      if (value.toString().contains('Nam')) {
        return "1";
      } else if (value.toString().contains('Nữ')) {
        return "2";
      }
      return '3';
    }
    return '3';
  }

  ///
  ///getGenderValueCreateQuestion
  ///
  static String getGenderValueCreateQuestion(dynamic value) {
    if (nullOrEmpty(value) == true) return 'ORTHER';

    if (value.runtimeType == String) {
      if (value.toString().contains('MALE')) {
        return 'MALE';
      } else if (value.toString().contains('FEMALE')) {
        return 'FEMALE';
      }
      return 'ORTHER';
    }
    return 'ORTHER';
  }
}
