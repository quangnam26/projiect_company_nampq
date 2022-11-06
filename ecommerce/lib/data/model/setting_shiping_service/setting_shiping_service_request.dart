import 'package:template/data/model/setting_shiping_service/setting_shiping_service_response.dart';

class SettingShipingServiceRequest extends SettingShipingServiceResponse {
  SettingShipingServiceRequest.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
