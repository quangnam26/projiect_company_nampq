import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/change_the_password_routes.dart';

import '../../../../data/model/provider/provider.dart';
import '../../../../helper/izi_alert.dart';
// import '../../../../routes/route_path/auth_routes.dart';

class ForgetPasswordController extends GetxController {
  final Provider provider = Provider();
  String? phone;
  UserProvider userProvider = UserProvider();

  void onBack() {
    Get.back();
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
    userProvider.paginate(
        page: 1,
        limit: 1,
        filter: "&phone=${phone!.replaceFirst("0", "")}",
        onSuccess: (data) {
         
          if (data.isNotEmpty) {
            Get.toNamed(ChangeThePassWordRoutes.CHANGE_THE_PASSWORD,
                arguments: data.first);
          } else {
            IZIAlert.error(
                message: "Số điện thoại không đúng hoặc không tồn tại ");
          }
        },
        onError: (onError) {
          IZIAlert.error(message: "Số điện thoại không tồn tại ");
        });
  }

  ///
  /// on go to login
  ///
  void onGoToLogin() {
    // Get.offAllNamed(
    //   AuthRoutes.LOGIN,
    // );
  }
}
