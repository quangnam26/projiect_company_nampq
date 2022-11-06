import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/specialize/Specialize_request.dart';

import '../datasource/remote/dio/dio_client.dart';

class SpecializeRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  SpecializeRepository();

  //
  //get all  specializes
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/specializes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add specialize to database
  ///
  Future<ApiResponse> add(SpecialzeRequest data) async {
    try {
      final response = await dioClient!.post('/specialize', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update specializes to database
  ///
  Future<ApiResponse> update(SpecialzeRequest data) async {
    try {
      final response = await dioClient!.put('/specializes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update specializes to database
  ///
  Future<ApiResponse> delete(String id, SpecialzeRequest data) async {
    try {
      final response = await dioClient!.delete('/specializes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate specializes "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/specializes/paginate?page=$page&limit=$limit'.toString();

      // add specializes filter
      if (filter != '') {
        uri = '/specializes/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate SpecializesAndSubSpecializes
  ///
  Future<ApiResponse> paginateSpecializesAndSubSpecializes() async {
    try {
      final String uri = '/specializes/paginate?fields=subSpecializes'.toString();
      print("capacity $uri");
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find specializes by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/specializes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// paginateSpecializesAndSubSpecializesMapping
  ///
  Future<ApiResponse> getSpecializesAndSubSpecializesMapping(String idUserSubSpecialize) async {
    try {
      final String uri = '/specializes/user-specialize/$idUserSubSpecialize/idUser'.toString();
      print("specialize uri $uri");
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
