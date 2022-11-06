import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/setting_payment_gateway/setting_payment_gateway_request.dart';
import 'package:template/data/model/setting_payment_gateway/setting_payment_gateway_response.dart';
import 'package:template/data/repositories/setting_payment_gateway_repository.dart';

class SettingPayMentGateWayProvider {
  SettingPayMentGateWayRepository? repository = GetIt.I.get<SettingPayMentGateWayRepository>();

  SettingPayMentGateWayProvider();

  ///
  /// Get all Categorys
  ///
  Future<void> all({
    required Function(List<SettingPayMentGateWayResponse> settingsPayMent) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => SettingPayMentGateWayResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert Category to database
  ///
  Future<void> add({
    required SettingPayMentGateWayRequest data,
    required Function(SettingPayMentGateWayRequest category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    
    final ApiResponse apiResponse = await repository!.add(data);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SettingPayMentGateWayRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Category to database
  ///
  Future<void> update({
    required SettingPayMentGateWayRequest data,
    required Function(SettingPayMentGateWayRequest settingPayMentGateWayRequest) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SettingPayMentGateWayRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Category to database
  ///
  Future<void> delete({
    required String id,
    required Function(SettingPayMentGateWayRequest settingPayMentGateWayRequest) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SettingPayMentGateWayRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Categorys "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<SettingPayMentGateWayResponse> settingsPayMent) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
        if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) => SettingPayMentGateWayResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Category to database
  ///
  Future<void> find({
    required String id,
    required Function(SettingPayMentGateWayResponse category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(SettingPayMentGateWayResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
