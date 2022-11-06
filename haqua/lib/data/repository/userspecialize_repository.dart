import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/userspecialize/userspecialize_responsi.dart';

class UserSpeciaLizeRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  UserSpeciaLizeRepository();

  //
  //get all subspecialize
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/user-specializes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add user-specializes to database
  ///
  Future<ApiResponse> add(UserSpecializeResponse data) async {
    try {
      final response =
          await dioClient!.post('/user-specializes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user-specializes to database
  ///
  Future<ApiResponse> update(String id,UserSpecializeResponse data) async {
    try {
      final response =
          await dioClient!.put('/user-specializes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user-specializes to database
  ///
  Future<ApiResponse> delete(String id, UserSpecializeResponse data) async {
    try {
      final response =
          await dioClient!.delete('/user-specializes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate user-specializes "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri =
          '/user-specializes/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/user-specializes/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find userspecialize by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/user-specializes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
