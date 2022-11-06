import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/news/news_request.dart';

class NewsReponsitory {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NewsReponsitory();

  ///
  /// Get all categorys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/news');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-bang-cap to database
  ///
  Future<ApiResponse> add(NewsRequest data) async {
    try {
      final response = await dioClient!.post('/categorys', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> update(NewsRequest data) async {
    try {
      final response = await dioClient!.put('/news', data: data.toJson());
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
      final response = await dioClient!.delete('/news/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate categorys "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/news/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/news/paginate?page=$page&limit=$limit$filter';
      }
      final response = await dioClient!.get(uri);
      print('object 00 $response');
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
      final String uri = '/news/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
