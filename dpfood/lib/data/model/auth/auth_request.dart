// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

class AuthRequest {
  String? phone;
  String? password;
  bool? isVerified;
  String? fcmToken;
  String? deviceID;
  AuthRequest({
    this.phone,
    this.password,
    this.fcmToken,
    this.deviceID,
    this.isVerified,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(phone))'phone': phone,
      if(!IZIValidate.nullOrEmpty(password))'password': password,
      if(!IZIValidate.nullOrEmpty(fcmToken))'fcmToken': fcmToken,
      if(!IZIValidate.nullOrEmpty(deviceID))'deviceID': deviceID,
      if(!IZIValidate.nullOrEmpty(isVerified))'isVerified': isVerified,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) => AuthRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
