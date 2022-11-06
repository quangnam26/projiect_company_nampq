import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/otp/otp_request.dart';
import 'package:template/data/repository/otp_repository.dart';

class OTPProvider with ChangeNotifier {
  OTPRepository? authRepository = GetIt.I.get<OTPRepository>();

  OTPProvider();

  ///
  /// Send OTP
  ///
  Future<void> sendOTP({
    required OTPRequest request,
    required Function(String otpCode) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.sendOTP(request);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final String otp = results as String;
      onSuccess(otp);
    } else {
      onError(apiResponse.error);
    }
  }
}
