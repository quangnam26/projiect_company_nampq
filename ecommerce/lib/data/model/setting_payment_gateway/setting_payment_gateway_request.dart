
import 'package:template/data/model/setting_payment_gateway/setting_payment_gateway_response.dart';

class SettingPayMentGateWayRequest extends SettingPayMentGateWayResponse{
  
  SettingPayMentGateWayRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}