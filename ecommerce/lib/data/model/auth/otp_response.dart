import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class OTPResponse {
  String? otp;
  OTPResponse({
    this.otp,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'otp': otp,
    };
  }

  factory OTPResponse.fromMap(Map<String, dynamic> map) {
    return OTPResponse(
      otp: map['otp'] != null ? map['otp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPResponse.fromJson(String source) => OTPResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
