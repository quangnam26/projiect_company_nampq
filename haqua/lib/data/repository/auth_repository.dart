import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/base/api_response.dart';

class AuthRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  AuthRepository();

  ///
  /// Sign Up HaQua
  ///
  Future<ApiResponse> signUpHaQua(AuthRequest data) async {
    try {
      final response = await dioClient!.post('/auth/signup-local', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Login HaQua
  ///
  Future<ApiResponse> loginHaQua(AuthRequest data) async {
    try {
      final response = await dioClient!.post('/auth/signin-local', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Login || Sign Up Google, Apple, Facebook
  ///
  Future<ApiResponse> loginSocial(AuthRequest data) async {
    try {
      final response = await dioClient!.post('/auth/signin-with-social', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
