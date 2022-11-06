import 'package:template/helper/izi_validate.dart';

class OTPResponse {
  String? phone;
  String? otpCode;
  OTPResponse({
    this.phone,
    this.otpCode,
  });

  ///
  /// From JSON
  ///
  OTPResponse.fromJson(Map<String, dynamic> json) {
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    otpCode = !IZIValidate.nullOrEmpty(json['otpCode']) ? json['otpCode'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;
    if (!IZIValidate.nullOrEmpty(otpCode)) data['otpCode'] = otpCode;

    return data;
  }

  @override
  String toString() => 'phone $phone, otpCode $otpCode';
}
