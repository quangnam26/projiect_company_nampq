import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/transaction/transaction_request.dart';
import 'package:template/data/model/transaction/transaction_response.dart';
import 'package:template/data/repository/transaction_repository.dart';

class TransactionProvider {
  TransactionRepository? regionRepo = GetIt.I.get<TransactionRepository>();

  TransactionProvider();

  ///
  /// Get all transaction
  ///
  Future<void> all({
    required Function(List<TransactionResponse> transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Add transaction to database
  ///
  Future<void> add({
    required TransactionRequest data,
    required Function(TransactionResponse userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TransactionRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Specialize to database
  ///
  Future<void> update({
    required TransactionRequest data,
    required Function(TransactionRequest transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TransactionRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete transaction to database
  ///
  Future<void> delete({
    required String id,
    required TransactionRequest data,
    required Function(TransactionRequest transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TransactionRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get transaction userSpcialize "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<TransactionResponse> transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => TransactionResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete transaction to database
  ///
  Future<void> find({
    required String id,
    required Function(TransactionResponse transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TransactionResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// withdraw Money
  /// 
  Future<void> withdrawMoney({
      required TransactionRequest data,
    required Function(TransactionResponse transaction) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.withDrawMoney(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(TransactionResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
