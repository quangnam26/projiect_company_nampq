import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/district/district_resquest.dart';
import 'package:template/data/repositories/district_reponsitory.dart';

class DistrictProvider {
  DistrictReponsitory? repository = GetIt.I.get<DistrictReponsitory>();

  DistrictProvider();

  ///
  /// Get all Districts
  ///
  Future<void> all({
    required Function(List<DistrictResponse> districts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => DistrictResponse.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert District to database
  ///
  Future<void> add({
    required DistrictRequest data,
    required Function(DistrictRequest district) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.add(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DistrictRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update District to database
  ///
  Future<void> update({
    required DistrictRequest data,
    required Function(DistrictRequest district) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DistrictRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete District to database
  ///
  Future<void> delete({
    required String id,
    required Function(DistrictRequest district) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DistrictRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Districts "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<DistrictResponse> districts) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]' ? apiResponse.response.data['results'] as List<dynamic> : [];
      onSuccess(results.map((e) => DistrictResponse.fromMap(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete District to database
  ///
  Future<void> find({
    required String id,
    required Function(DistrictResponse district) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(DistrictResponse.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
