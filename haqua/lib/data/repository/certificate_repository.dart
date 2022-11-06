import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import '../model/certificate/certificate_request.dart';

class CertificateRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  CertificateRepository();

  //
  //get all certificates
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/certificates');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add certificates to database
  ///
  Future<ApiResponse> add(CertificateRequest data) async {
    try {
      final response = await dioClient!.post('/certificates', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update certificates to database
  ///
  Future<ApiResponse> update(CertificateRequest data) async {
    try {
      final response = await dioClient!.put('/certificates', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete certificates to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/certificates/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate certificates "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter, String id) async {
    try {
      String uri = '/certificates/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/certificates/paginate?page=$page&limit=$limit$filter&idUser=$id';
      }

      print('url certificates $uri');

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find certificates by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/certificates/$id?populate=idSubSpecialize';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
