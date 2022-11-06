import 'package:template/data/model/setting_payment_gateway/setting_payment_gateway_response.dart';

import '../../../helper/izi_validate.dart';

class SettingShipingServiceResponse extends SettingPayMentGateWayResponse {
  int? fee;
  SettingShipingServiceResponse({
    this.fee,
  });

  SettingShipingServiceResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    fee = (json['_id'] == null) ? null : int.parse(json['_id'].toString());
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (!IZIValidate.nullOrEmpty(fee)) data['fee'] = fee;

    return data;
  }
}

enum Type { FIXED, API }
