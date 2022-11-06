import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/category/category_request.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/repositories/category_reponsitory.dart';

class CategoryProvider {
  CategoryReponsitory? repository = GetIt.I.get<CategoryReponsitory>();

  CategoryProvider();

  ///
  /// Get all news
  ///
  Future<void> all({
    required Function(List<CategoryResponse> categoryResponse) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert news to database
  ///
  Future<void> add({
    required CategoryRequest data,
    required Function(CategoryRequest categoryRequest) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update news to database
  ///
  Future<void> update({
    required CategoryRequest data,
    required Function(CategoryRequest categoryRequest) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete news to database
  ///
  Future<void> delete({
    required String id,
    required Function(CategoryRequest categoryRequest) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate news "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<CategoryResponse> categoryResponse) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(
        results
            .map((e) => CategoryResponse.fromJson(e as Map<String, dynamic>))
            .toList(),

           
      );
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete news to database
  ///
  Future<void> find({
    required String id,
    required Function(CategoryResponse categoryResponse) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CategoryResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
