// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:template/helper/izi_validate.dart';

import '../user/user_response.dart';

class AuthResponse {
  String? accessToken;
  String? refreshToken;
  UserResponse? user;
  String? typeRegister;
  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.typeRegister,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(accessToken)) 'accessToken': accessToken,
      if (!IZIValidate.nullOrEmpty(refreshToken)) 'refreshToken': refreshToken,
      if (!IZIValidate.nullOrEmpty(user)) 'user': user?.toMap(),
      if (!IZIValidate.nullOrEmpty(typeRegister)) 'typeRegister': typeRegister,
    };
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      accessToken:
          map['accessToken'] != null ? map['accessToken'] as String : null,
      refreshToken:
          map['refreshToken'] != null ? map['refreshToken'] as String : null,
      user: map['user'] != null
          ? UserResponse.fromMap(map['user'] as Map<String, dynamic>)
          : null,
            typeRegister: map['typeRegister'] != null ? map['typeRegister'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
