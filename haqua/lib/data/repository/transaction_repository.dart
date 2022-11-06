import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/transaction/transaction_request.dart';

class TransactionRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  TransactionRepository();

  //
  //get all transactions
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/transactions');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add transaction to database
  ///
  Future<ApiResponse> add(TransactionRequest data) async {
    try {
      final response = await dioClient!.post('/transactions', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update transactions to database
  ///
  Future<ApiResponse> update(TransactionRequest data) async {
    try {
      final response = await dioClient!.put('/transactions', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update transactions to database
  ///
  Future<ApiResponse> delete(String id, TransactionRequest data) async {
    try {
      final response = await dioClient!.delete('/transactions/$id', data: data.toJson());
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
      String uri = '/transactions/paginate?page=$page&limit=$limit'.toString();

      // add specializes filter
      if (filter != '') {
        uri = '/transactions/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find transaction by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/transactions/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add transaction to database
  ///
  Future<ApiResponse> withDrawMoney(TransactionRequest data) async {
    try {
      final response = await dioClient!.put('/transactions/withdraw-money', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
