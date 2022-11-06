import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/setting/setting_response.dart';
import 'package:template/provider/settings_provider.dart';

class ContactController extends GetxController {
// khai bao API
  final SettingsProvider settingsProvider = GetIt.I.get<SettingsProvider>();
  SettingResponse? settingResponse;

  ///List
  List<SettingResponse> listSettingResponse = [];
  List<Map<String, dynamic>> listContact = [];

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    getDataSetting();
  }

  ///
  ///getDataSetting
  ///

  void getDataSetting() {
    settingsProvider.all(
      onSuccess: (val) {
        listSettingResponse = val;
        settingResponse = listSettingResponse.first;
        listContact = [
          {
            'name': 'Địa chỉ:',
            'title': settingResponse!.address ?? "",
          },
          {
            'name': 'Tổng đài CSKH:',
            'title': settingResponse!.hotline,
          },
          {
            'name': 'Email:',
            'title': settingResponse!.email,
          },
          {
            'name': 'Tổng đài hổ trợ (7h30 đến 20h):',
            'title': settingResponse!.contact,
          },
          {
            'name': 'Website:',
            'title': settingResponse!.website,
          },
        ];
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }
}
