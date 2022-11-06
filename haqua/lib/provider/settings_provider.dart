import 'package:get_it/get_it.dart';
import 'package:template/data/repository/settings_repository.dart';

import '../data/model/base/api_response.dart';
import '../data/model/settings/settings_reponse.dart';
import '../helper/izi_validate.dart';

class SettingsProvider {
  SettingsRepository? regionRepo = GetIt.I.get<SettingsRepository>();

  SettingsProvider();

  ///
  /// Find setting.
  ///
  Future<void> findSetting({
    required Function(SettingResponse? data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.findSettings();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      if (!IZIValidate.nullOrEmpty(results)) {
        onSuccess(results.map((e) => SettingResponse.fromJson(e as Map<String, dynamic>)).toList().first);
      } else {
        onSuccess(null);
      }
    } else {
      onError(apiResponse.error);
    }
  }
}
