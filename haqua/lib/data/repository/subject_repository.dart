import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/subject/subject_request.dart';

class SubjectRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  SubjectRepository();

  //
  //get all subjects
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/subjects');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add subjects to database
  ///
  Future<ApiResponse> add(SubjectRequest data) async {
    try {
      final response = await dioClient!.post('/subjects', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update subjects to database
  ///
  Future<ApiResponse> update(SubjectRequest data) async {
    try {
      final response = await dioClient!.put('/subjects', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete subjects to database
  ///
  Future<ApiResponse> delete(String id, SubjectRequest data) async {
    try {
      final response =
          await dioClient!.delete('/subjects/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate subjects "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/subjects/paginate?page=$page&limit=$limit'.toString();

 
      if (filter != '') {
        uri = '/subjects/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find subjects by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/subjects/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
