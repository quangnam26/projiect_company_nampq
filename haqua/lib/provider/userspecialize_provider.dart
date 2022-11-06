import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/userspecialize/userspecialize_request.dart';
import 'package:template/data/model/userspecialize/userspecialize_responsi.dart';
import 'package:template/data/repository/userspecialize_repository.dart';

class UserSpecializeProvider {
  UserSpeciaLizeRepository? regionRepo = GetIt.I.get<UserSpeciaLizeRepository>();

  UserSpecializeProvider();

  ///
  /// Get all userSpcialize
  ///
  Future<void> all({
    required Function(List<UserSpecializeResponse> userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => UserSpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Add userSpcialize to database
  ///
  Future<void> add({
    required UserSpecializeResponse data,
    required Function(UserSpecializeResponse userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserSpecializeResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Specialize to database
  ///
  Future<void> update({
    required String id,
    required UserSpecializeRequest data,
    required Function(UserSpecializeResponse userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(id,data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserSpecializeResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete userSpcialize to database
  ///
  Future<void> delete({
    required String id,
    required UserSpecializeRequest data,
    required Function(UserSpecializeResponse userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserSpecializeResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate userSpcialize "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<UserSpecializeResponse> userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    print("Filter userSpcialize $filter");
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => UserSpecializeResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete userSpcialize to database
  ///
  Future<void> find({
    required String id,
    required Function(UserSpecializeRequest userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserSpecializeRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }


}
