import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/subspecialize/subspecialize_request.dart';

class SubSpecializeRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  SubSpecializeRepository();

  //
  //get all sub-specializes
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/sub-specializes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add sub-specializes to database
  ///
  Future<ApiResponse> add(SubSpecializeRequest data) async {
    try {
      final response =
          await dioClient!.post('/sub-specializes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update sub-specializes to database
  ///
  Future<ApiResponse> update(SubSpecializeRequest data) async {
    try {
      final response =
          await dioClient!.put('/sub-specializes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update sub-specializes to database
  ///
  Future<ApiResponse> delete(String id, SubSpecializeRequest data) async {
    try {
      final response =
          await dioClient!.delete('/sub-specializes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate sub-specializes "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/sub-specializes/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/sub-specializes/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find sub-specializes by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/sub-specializes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
