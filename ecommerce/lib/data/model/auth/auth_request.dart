// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

import '../user/user_response.dart';

class AuthRequest {
  String? fullName;
  String? phone;
  String? password;
  String? tokenLogin;
  String? deviceID;
  String? otpCode;
  UserResponse? user;
  String? typeRegister;
  AuthRequest(
      {this.fullName,
      this.phone,
      this.password,
      this.tokenLogin,
      this.deviceID,
      this.otpCode,
      this.typeRegister,
      this.user});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if (!IZIValidate.nullOrEmpty(typeRegister)) 'typeRegister': typeRegister,
      if (!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if (!IZIValidate.nullOrEmpty(password)) 'password': password,
      if (!IZIValidate.nullOrEmpty(tokenLogin)) 'tokenLogin': tokenLogin,
      if (!IZIValidate.nullOrEmpty(deviceID)) 'deviceID': deviceID,
      if (!IZIValidate.nullOrEmpty(otpCode)) 'otpCode': otpCode,
      if (!IZIValidate.nullOrEmpty(user)) 'user': user?.toMap(),
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      // fullName: map['fullName'] != null ? map['fullName'] as String : null,
      typeRegister:
          map['typeRegister'] != null ? map['typeRegister'] as String : null,
      deviceID: map['deviceID'] != null ? map['deviceID'] as String : null, 
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      otpCode: map['otpCode'] != null ? map['otpCode'] as String : null,
      tokenLogin:
          map['tokenLogin'] != null ? map['tokenLogin'] as String : null,
      user: map['user'] != null
          ? UserResponse.fromMap(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum GenderEnum {
  ORTHER,
  MALE,
  FEMALE,
}

enum TypeRegisterEnum {
  GOOGLE,
  FACEBOOK,
  APPLE,
  LOCAL,
  EMAIL,
}
