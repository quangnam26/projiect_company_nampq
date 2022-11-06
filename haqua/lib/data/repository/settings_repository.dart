import 'package:get_it/get_it.dart';

import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class SettingsRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();
  SettingsRepository();

  ///
  /// Get setting.
  ///
  Future<ApiResponse> findSettings() async {
    try {
      final String uri = '/settings/paginate?page=1&limit=1'.toString();

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
