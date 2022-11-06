import 'package:get/get.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/routes/route_path/auth_routes.dart';

import '../../../../data/model/provider/provider.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../helper/izi_validate.dart';

class UpdatePasswordController extends GetxController {
  final Provider provider = Provider();
  String phone = "";
  String password = "";
  String newPassword = "";
  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      phone = arg.toString();
    }
  }

  ///
  /// update password
  ///
  void onUpdatePassword() {
    if (isValidateUpdatePassword()) {
      provider.add(
        UserRequest(),
        requestBody: AuthRequest(
          phone: phone,
          password: password,
        ),
        endPoint: '/update-password',
        onSuccess: (data) {
          IZIAlert.success(message: "Cập nhật mật khẩu thành công");
          onToLogin();
        },
        onError: (onError) {
          IZIAlert.error(message: "Không tìm thấy số điện thoại.");
          onToLogin();
          print("An error occurred while updating the password $onError");
        },
      );
    }
  }

  ///
  /// validate update password
  ///
  bool isValidateUpdatePassword() {
    if (IZIValidate.nullOrEmpty(password)) {
      IZIAlert.error(message: "Mật khẩu không được để trống");
      return false;
    } else if (IZIValidate.nullOrEmpty(newPassword)) {
      IZIAlert.error(message: "Mật khẩu không trung khớp");
      return false;
    }
    return true;
  }

  ///
  /// on forget password button
  ///
  void onToLogin() {
    Get.offAllNamed(
      AuthRoutes.LOGIN,
    );
  }
}
