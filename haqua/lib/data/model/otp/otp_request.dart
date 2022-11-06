import 'package:template/data/model/otp/otp_response.dart';

class OTPRequest extends OTPResponse {
  OTPRequest();
  OTPRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
