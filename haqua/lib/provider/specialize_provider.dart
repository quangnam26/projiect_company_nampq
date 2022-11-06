import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/specialize/Specialize_request.dart';
import 'package:template/data/model/specialize/specialize_response.dart';
import 'package:template/data/model/specialize_and_%20sub_specialize/specialize_and_%20sub_specialize_response.dart';
import 'package:template/data/repository/specialize_reponsitory.dart';

class SpecializeProvider {
  SpecializeRepository? regionRepo = GetIt.I.get<SpecializeRepository>();

  SpecializeProvider();

  ///
  /// Get all Specialize
  ///
  Future<void> all({
    required Function(List<SpecializeResponse> specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => SpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Add Specialize to database
  ///
  Future<void> add({
    required SpecialzeRequest data,
    required Function(SpecialzeRequest banner) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SpecialzeRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Specialize to database
  ///
  Future<void> update({
    required SpecialzeRequest data,
    required Function(SpecialzeRequest specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SpecialzeRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Specialize to database
  ///
  Future<void> delete({
    required String id,
    required SpecialzeRequest data,
    required Function(SpecialzeRequest specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SpecialzeRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Specialize "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<SpecializeResponse> specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => SpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Specialize "page": 1, "limit": 10
  ///
  Future<void> paginateSpecializesAndSubSpecializes({
    required Function(List<SpecializeAndSubSpecializeResponse> specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginateSpecializesAndSubSpecializes();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      print(results);
      onSuccess(results.map((e) => SpecializeAndSubSpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Specialize to database
  ///
  Future<void> find({
    required String id,
    required Function(SpecializeResponse specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SpecializeResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// getSpecializesAndSubSpecializesMapping
  ///
  Future<void> getSpecializesAndSubSpecializesMapping({
    required String idUserSubSpecialize,
    required Function(List<SpecializeAndSubSpecializeResponse> specialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.getSpecializesAndSubSpecializesMapping(idUserSubSpecialize);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      print(results);
      onSuccess(results.map((e) => SpecializeAndSubSpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }
}
