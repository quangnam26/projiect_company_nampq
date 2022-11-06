// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

class AuthRequest {
  String? fullName;
  String? phone;
  String? password;
  String? fcmToken;
  String? deviceID;
  String? otpCode;
  AuthRequest({
    this.fullName,
    this.phone,
    this.password,
    this.fcmToken,
    this.deviceID,
    this.otpCode,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(fullName))'fullName': fullName,
      if(!IZIValidate.nullOrEmpty(phone))'phone': phone,
      if(!IZIValidate.nullOrEmpty(password))'password': password,
      if(!IZIValidate.nullOrEmpty(fcmToken))'fcmToken': fcmToken,
      if(!IZIValidate.nullOrEmpty(deviceID))'deviceID': deviceID,
      if(!IZIValidate.nullOrEmpty(otpCode))'otpCode': otpCode,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      otpCode: map['otpCode'] != null ? map['otpCode'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) => AuthRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
