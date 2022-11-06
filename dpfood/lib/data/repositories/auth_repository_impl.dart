import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_in_employee_to_salary.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../datasource/remote/exception/api_error_handler.dart';
import '../model/auth/auth_request.dart';
import '../model/base/api_response.dart';

class AuthRepository{
  DioClient? dioClient = GetIt.I.get<DioClient>();
  SharedPreferenceHelper? sharedPreferences =
      GetIt.I.get<SharedPreferenceHelper>();

  AuthRepository();


  ///
  /// Signin with email
  ///
  Future<ApiResponse> signin(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/signin', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Signin to Employee with email
  ///
  Future<ApiResponse> loginGoogle(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/signin', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandlerInEmployee.getMessage(e));
    }
  }

  ///
  /// register
  ///
  Future<ApiResponse> register(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/auth/signup', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Đăng nhập bằng tài khoản số điện thoại
  ///
  Future<ApiResponse> loginFacebook(AuthRequest request) async {
    try {
      final response =
          await dioClient!.post('/tai-khoans/signin', data: request.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  ///
  /// Đăng xuất tài khoản số điện thoại
  ///
  Future<ApiResponse> logout(dynamic request) async {
    try {
      final response =
          await dioClient!.post('/auth/logout', data: json.encode(request));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Forget password
  ///
  Future<ApiResponse> forgetPassword(dynamic phone) async {
    try {
      final response = await dioClient!
          .post('/tai-khoans/forgot-password', data: json.encode(phone));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Verify otp
  ///
  // Future<ApiResponse> verifyOTP(VerifyOtpRequest request) async {
  //   try {
  //     final response = await dioClient!
  //         .post('/tai-khoans/verifier-otp', data: request.toJson());
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  ///
  /// reset pass
  ///
  // Future<ApiResponse> resetPassword(VerifyOtpRequest request) async {
  //   try {
  //     final response = await dioClient!
  //         .post('/tai-khoans/reset-password', data: request.toJson());
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  ///
  /// send otp
  ///
  // Future<ApiResponse> sendOTP(dynamic phone) async {
  //   try {
  //     final response = await dioClient!
  //         .post('/tai-khoans/sent-otp', data: json.encode(phone));
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }



}
