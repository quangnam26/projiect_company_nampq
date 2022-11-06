import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class OTPRequest {
  String? phone;
  OTPRequest({
    this.phone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'phone': phone,
    };
  }

  factory OTPRequest.fromMap(Map<String, dynamic> map) {
    return OTPRequest(
      phone: map['phone'] != null ? map['phone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OTPRequest.fromJson(String source) => OTPRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
