import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/policyandterm/policy_and_term_request.dart';
import 'package:template/data/model/policyandterm/policy_and_term_response.dart';
import 'package:template/data/repositories/policy_and_term_reponsitory.dart';

class PolicyAndTermProvider {
  PolicyAndTermReponsitory? repository = GetIt.I.get<PolicyAndTermReponsitory>();

  PolicyAndTermProvider();

  ///
  /// Get all news
  ///
  Future<void> all({
    required Function(List<PolicyAndTermResponse> categorys) onSuccess,
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
          .map((e) => PolicyAndTermResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert news to database
  ///
  Future<void> add({
    required PolicyAndTermResquest data,
    required Function(PolicyAndTermResquest newsRequest) onSuccess,
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
      onSuccess(PolicyAndTermResquest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update news to database
  ///
  Future<void> update({
    required PolicyAndTermResquest data,
    required Function(PolicyAndTermResquest newsRequest) onSuccess,
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
      onSuccess(PolicyAndTermResquest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete news to database
  ///
  Future<void> delete({
    required String id,
    required Function(PolicyAndTermResquest newsRequest) onSuccess,
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
      onSuccess(PolicyAndTermResquest.fromJson(results as Map<String, dynamic>));
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
    required Function(List<PolicyAndTermResponse> newsResponse) onSuccess,
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
            .map((e) => PolicyAndTermResponse.fromJson(e as Map<String, dynamic>))
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
    required Function(PolicyAndTermResponse newsResponse) onSuccess,
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
      onSuccess(PolicyAndTermResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
