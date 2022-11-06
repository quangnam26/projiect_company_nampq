import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/province/province_request.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/repository/province_repository.dart';

class ProvinceProvider {
  ProvinceRepository? regionRepo = GetIt.I.get<ProvinceRepository>();

  ProvinceProvider();

  ///
  /// Get all subject
  ///
  Future<void> all({
    required Function(List<ProvinceResponse> provinces) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ProvinceResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  // ///
  // /// Insert subject to database
  // ///
  // Future<void> add({
  //   required SubjectResponse data,
  //   required Function(SubSpecializeResponse subject) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //   final ApiResponse apiResponse = await regionRepo!.add(data);
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data as dynamic;
  //     onSuccess(
  //         SubSpecializeResponse.fromJson(results as Map<String, dynamic>));
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }

  ///
  /// Update Specialize to database
  ///
  Future<void> update({
    required ProvinceRequest data,
    required String id,
    required Function(ProvinceResponse provinces) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data,id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProvinceResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete subject to database
  ///
  Future<void> delete({
    required String id,
    required ProvinceResponse data,
    required Function(ProvinceResponse userSpcialize) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete( data,id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProvinceResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate  "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ProvinceResponse> provinces) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results
          .map((e) => ProvinceResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete subject to database
  ///
  Future<void> find({
    required String id,
    required Function(ProvinceResponse provinces) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ProvinceResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
