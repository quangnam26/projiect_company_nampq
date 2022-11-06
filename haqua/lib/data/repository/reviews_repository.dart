import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/reviews/reviews_request.dart';

import '../datasource/remote/dio/dio_client.dart';

class ReviewsReponsitory {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ReviewsReponsitory();

  //
  //get all  reviews
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/reviews');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add reviews to database
  ///
  Future<ApiResponse> add(ReviewsRequest data) async {
    try {
      final response = await dioClient!.post('/reviews', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update specialize to database
  ///
  Future<ApiResponse> update(ReviewsRequest data) async {
    try {
      final response = await dioClient!.put('/reviews', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete specialize to database
  ///
  Future<ApiResponse> delete(String id, ReviewsRequest data) async {
    try {
      final response = await dioClient!.delete('/reviews/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate specialize "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/reviews/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/reviews/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find specialize by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/reviews/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
