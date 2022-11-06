// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginRequest {
  String? phone;
  String? password;
  String? fcmToken;
  LoginRequest({
    this.phone,
    this.password,
    this.fcmToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
      'password': password,
      'fcmToken': fcmToken,
    };
  }

  factory LoginRequest.fromMap(Map<String, dynamic> map) {
    return LoginRequest(
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      fcmToken: map['fcmToken'] != null ? map['fcmToken'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequest.fromJson(String source) =>
      LoginRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
