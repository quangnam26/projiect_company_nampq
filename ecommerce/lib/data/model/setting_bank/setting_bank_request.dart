import 'package:template/data/model/setting_bank/setting_bank_response.dart';

class SettingBankRequest extends SettingBankResponse{
  
  SettingBankRequest.fromJson(Map<String, dynamic> json):super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}