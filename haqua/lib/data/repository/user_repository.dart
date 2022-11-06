import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_request.dart';

class UserRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  UserRepository();

  ///
  /// Update user to database
  ///
  Future<ApiResponse> update(UserRequest data) async {
    try {
      final response = await dioClient!.put('/users/update-me', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find user by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/users/$id';
      print("uri find by id User $uri");
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Withdraw user to database
  ///
  Future<ApiResponse> withDrawMoney(UserRequest data) async {
    try {
      final response = await dioClient!.put('/users/withdraw-money', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/users/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

   ///
  /// changeStatusFCM user to database
  ///
  Future<ApiResponse> changeStatusFCM(String idUser,UserRequest data) async {
    try {
      final response = await dioClient!.put('/users/$idUser/enable-fcm', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
