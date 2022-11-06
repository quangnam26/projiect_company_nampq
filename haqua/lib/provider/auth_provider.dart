import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/repository/auth_repository.dart';
import 'package:template/helper/izi_validate.dart';

class AuthProvider with ChangeNotifier {
  AuthRepository? authRepository = GetIt.I.get<AuthRepository>();

  AuthProvider();

  ///
  /// Login HaQua
  ///
  Future<void> loginHaQua({
    required AuthRequest request,
    required Function(UserResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.loginHaQua(request);
    if (!IZIValidate.nullOrEmpty(apiResponse.response) && apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final UserResponse authResponse = UserResponse.fromJson(results['user'] as Map<String, dynamic>);
      authResponse.accessToken = results['accessToken'].toString();
      authResponse.refreshToken = results['refreshToken'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Login || Sign Up Google, Apple, Facebook
  ///
  Future<void> loginSocial({
    required AuthRequest request,
    required Function(UserResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.loginSocial(request);
    print(request.toJson());
    if (!IZIValidate.nullOrEmpty(apiResponse.response) && apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final UserResponse authResponse = UserResponse.fromJson(results['user'] as Map<String, dynamic>);
      authResponse.accessToken = results['accessToken'].toString();
      authResponse.refreshToken = results['refreshToken'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Sign Up HaQua
  ///
  Future<void> signUpHaQua({
    required AuthRequest request,
    required Function(UserResponse auth) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await authRepository!.signUpHaQua(request);
    print(request.toJson());

    if (!IZIValidate.nullOrEmpty(apiResponse.response) && apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      final UserResponse authResponse = UserResponse.fromJson(results['user'] as Map<String, dynamic>);
      authResponse.accessToken = results['accessToken'].toString();
      authResponse.refreshToken = results['refreshToken'].toString();
      onSuccess(authResponse);
    } else {
      onError(apiResponse.error);
    }
  }
}
