import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/repositories/auth_repository_impl.dart';

import '../data/model/auth/auth_request.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository? authRepository = GetIt.I.get<AuthRepository>();

  AuthProvider();

  ///
  /// login with employee
  ///
  Future<void> signin({
    required AuthRequest request,
    required Function(AuthResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.signin(request);
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthResponse authResponse =
          AuthResponse.fromMap(results as Map<String, dynamic>);
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }


  ///
  /// login
  ///
  Future<void> register({
    required AuthRequest request,
    required Function(AuthResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.register(request);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final AuthResponse authResponse =
          AuthResponse.fromMap(results as Map<String, dynamic>);
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  /// Dăng nhập bằng ttài khoản (SĐT)

  

  ///
  /// Quên mật khẩu
  ///
  Future<void> forgetPassword({
    required dynamic phone,
    required Function(String data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.forgetPassword(phone);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      // final TaiKhoanResponse account = TaiKhoanResponse();
      // account.resetPasswordToken= results['resetPasswordToken'].toString();
      final String resetPasswordToken =
          results['resetPasswordToken'].toString();
      print("Token: ${results['otp'].toString()}");
      onSuccess(resetPasswordToken);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Verify OTP
  ///
  // Future<void> verifyOTP({
  //   required VerifyOtpRequest request,
  //   required Function(bool data) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse = await authRepository!.verifyOTP(request);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data as dynamic;
  //     final bool status = results['status'] as bool;
  //     onSuccess(status);
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }

  ///
  /// reset passowrd
  ///
  // Future<void> resetPassword({
  //   required VerifyOtpRequest request,
  //   required Function() onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse =
  //       await authRepository!.resetPassword(request);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     onSuccess();
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }

  ///
  /// send otp
  ///
  // Future<void> sendOTP({
  //   required dynamic phone,
  //   required Function(String registerToken) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse = await authRepository!.sendOTP(phone);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data as dynamic;
  //     print(apiResponse.response.data['otp']);
  //     onSuccess(results['registerToken'] as String);
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }
}
