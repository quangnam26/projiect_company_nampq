import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/user/user_change_passowrd_request.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class ChangePassWordController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController rePassword = TextEditingController();

  RxString idUser = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile.obs;
  }

  ///
  ///onSummit
  ///
  void onSummit() {
    if (newPassword.text.length < 6) {
      IZIAlert.error(message: 'Mật khẩu mới phải 6 ký tự');
    } else if (newPassword.text != rePassword.text) {
      IZIAlert.error(message: 'Mật khẩu mới chưa khớp');
    } else {
      final UserChangePasswordRequest userChangePasswordRequest =
          UserChangePasswordRequest(
              idUser: idUser.value,
              oldPassword: oldPassword.text,
              newPassword: newPassword.text);
      EasyLoading.show(status: 'loading...');
      userProvider.changePassword(
          data: userChangePasswordRequest,
          onSuccess: (data) {
            EasyLoading.dismiss();
            IZIDialog.showDialog(
                lable: 'Thông báo',
                confirmLabel: 'Đồng ý',
                description: 'Đổi mật khẩu thành công, vui lòng đăng nhập lại',
                onConfirm: () {
                  Get.offAndToNamed(SplashRoutes.SPLASH);
                },
                onCancel: () {
                  Get.offAndToNamed(SplashRoutes.SPLASH);
                },
                cancelLabel: 'Thoát');
          },
          onError: (onError) {
            print(onError);
            EasyLoading.dismiss();
            IZIAlert.error(message: 'Mật khẩu cũ không đúng');
          });
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    oldPassword.dispose();
    newPassword.dispose();
    rePassword.dispose();
    super.onClose();
  }
}
