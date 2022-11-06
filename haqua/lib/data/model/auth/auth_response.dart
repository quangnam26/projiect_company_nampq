import 'package:template/helper/izi_validate.dart';

class AuthResponse {
  String? phone;
  String? password;
  String? deviceId;
  String? tokenLogin;
  String? avatar;
  String? otpCode;
  String? typeRegister;
  String? fullName;
  AuthResponse({
    this.phone,
    this.password,
    this.deviceId,
    this.tokenLogin,
    this.avatar,
    this.fullName,
    this.typeRegister,
    this.otpCode,
  });

  ///
  /// From JSON
  ///
  AuthResponse.fromJson(Map<String, dynamic> json) {
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    password = !IZIValidate.nullOrEmpty(json['password']) ? json['password'].toString() : null;
    typeRegister = !IZIValidate.nullOrEmpty(json['typeRegister']) ? json['typeRegister'].toString() : null;
    tokenLogin = !IZIValidate.nullOrEmpty(json['tokenLogin']) ? json['tokenLogin'].toString() : null;
    deviceId = !IZIValidate.nullOrEmpty(json['deviceID']) ? json['deviceID'].toString() : null;
    avatar = !IZIValidate.nullOrEmpty(json['avatar']) ? json['avatar'].toString() : null;
    fullName = !IZIValidate.nullOrEmpty(json['fullName']) ? json['fullName'].toString() : null;
    otpCode = !IZIValidate.nullOrEmpty(json['otpCode']) ? json['otpCode'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;
    if (!IZIValidate.nullOrEmpty(otpCode)) data['otpCode'] = otpCode;
    if (!IZIValidate.nullOrEmpty(password)) data['password'] = password;
    if (!IZIValidate.nullOrEmpty(typeRegister)) data['typeRegister'] = typeRegister;
    if (!IZIValidate.nullOrEmpty(tokenLogin)) data['tokenLogin'] = tokenLogin;
    if (!IZIValidate.nullOrEmpty(deviceId)) data['deviceID'] = deviceId;
    if (!IZIValidate.nullOrEmpty(avatar)) data['avatar'] = avatar;
    if (!IZIValidate.nullOrEmpty(fullName)) data['fullName'] = fullName;

    return data;
  }
}
