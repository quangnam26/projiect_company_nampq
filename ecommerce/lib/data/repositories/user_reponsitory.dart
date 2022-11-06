import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_request.dart';

class UserRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  UserRepository();

  ///
  /// Get all users
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/users');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-bang-cap to database
  ///
  Future<ApiResponse> add(UserRequest data) async {
    try {
      final response = await dioClient!.post('/users', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> update(UserRequest data, String id) async {
    try {
      final response = await dioClient!.put('/users/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
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
  /// Get paginate users "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/users/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/users/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/users/$id';

      print('check url find user $uri');

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> checkPassword(String idUser, String password) async {
    try {
      final response = await dioClient!
          .get('/users/$idUser/check-password?password=$password');

      print("kaka $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  Future<ApiResponse> updatePassword(UserRequest data) async {
    try {
      final response =
          await dioClient!.put('/users/update-password', data: data.toJson());

      print("kaka $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
    Future<ApiResponse> updatePasswordbyPhone(UserRequest data) async {
    try {
      final response = await dioClient!
          .put('/users/update-password/phone', data: data.toJson());

      print("kaka $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
