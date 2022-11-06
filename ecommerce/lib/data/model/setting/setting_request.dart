import 'package:template/data/model/setting/setting_response.dart';

class SettingRequest extends SettingResponse {
  SettingRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
