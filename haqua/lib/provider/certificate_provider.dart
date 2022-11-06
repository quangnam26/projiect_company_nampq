import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/certificate/certificate_request.dart';
import 'package:template/data/model/certificate/certificate_response.dart';

import '../data/repository/certificate_repository.dart';

class CertificateProvider {
  CertificateRepository? regionRepo = GetIt.I.get<CertificateRepository>();

  CertificateProvider();

  ///
  /// Get all Certificate.
  ///
  Future<void> all({
    required Function(List<CertificateResponse> quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => CertificateResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Add Certificate to database
  ///
  Future<void> add({
    required CertificateRequest data,
    required Function(CertificateResponse quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CertificateResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Certificate to database
  ///
  Future<void> update({
    required CertificateRequest data,
    required Function(CertificateResponse quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CertificateResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Certificate to database
  ///
  Future<void> delete({
    required String id,
    required Function(CertificateResponse quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CertificateResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Certificate "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required String id,
    required int page,
    required int limit,
    required String filter,
    required Function(List<CertificateResponse> quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter, id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => CertificateResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Certificate to database
  ///
  Future<void> find({
    required String id,
    required Function(CertificateResponse quiz) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(CertificateResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
