import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';

import '../../../../data/model/provider/provider.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../routes/route_path/auth_routes.dart';
import '../../../../sharedpref/constants/enum_helper.dart';

class ForgetPasswordController extends GetxController {
  final Provider provider = Provider();
  String? phone;
  AuthEnum authEnum = AuthEnum.FORGET_PASSWORD;

  void onBack() {
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    final arg = Get.arguments;
    print(arg);
    if (arg != null) {
      authEnum = arg as AuthEnum;
    }
  }

  ///
  /// verify confirm
  ///
  void updatePassword() {
    if (validate()) {
      onToUpdatePassword();
      // provider.all(
      //   UserRequest(),
      //   endPoint: '?phone=$phone',
      //   onSuccess: (data) {
      //     if (IZIValidate.nullOrEmpty(data)) {
      //       IZIAlert.error(message: "Tài khoản không tồn tại");
      //     } else {
      //       onToUpdatePassword();
      //     }
      //   },
      //   onError: (onError) {
      //     print("An error occurred while updating the password $onError");
      //   },
      // );
    }
  }

  bool validate() {
    if (IZIValidate.nullOrEmpty(phone)) {
      IZIAlert.error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.phone(phone!) != null) {
      IZIAlert.error(message: "Số điện thoại không hợp lệ");
      return false;
    }
    return true;
  }

  void onToUpdatePassword() {
    Get.toNamed(AuthRoutes.VERIFY, arguments: {phone: phone, 'type': authEnum});
  }

  ///
  /// on go to login
  ///
  void onGoToLogin() {
    Get.offAllNamed(
      AuthRoutes.LOGIN,
    );
  }
}
