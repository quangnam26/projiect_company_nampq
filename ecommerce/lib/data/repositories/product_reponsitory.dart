import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/product/product_request.dart';

class ProductRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ProductRepository();

  ///
  /// Get all products
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/products');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-bang-cap to database
  ///
  Future<ApiResponse> add(ProductRequest data) async {
    try {
      final response = await dioClient!.post('/products', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> update(ProductRequest data) async {
    try {
      final response = await dioClient!.put('/products', data: data.toJson());
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
      final response = await dioClient!.delete('/products/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate products "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/products/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/products/paginate?page=$page&limit=$limit$filter';
      }
      // print(" flitter11 $filter");
      print('manh filter $filter');
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<ApiResponse> find(String id, {String? filter}) async {
    try {
      String uri = '/products/$id';
      if (filter != null) {
        uri += '&populate=$filter';
      }
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Favorite.
  /// "idProduct":"631aa9c58ce0c3e4c2601e53",
  // "userId":"63042cbfd43cd17a308ed9c9"
  ///
  Future<ApiResponse> favorite(String userId, String idProduct) async {
    try {
      const String uri = '/products/favorite';
      final response = await dioClient!.post(uri, data: {"userId": userId, "idProduct": idProduct});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
