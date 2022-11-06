import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';

import '../../../../data/model/auth/auth_request.dart';
import '../../../../data/model/provider/provider.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../helper/izi_validate.dart';

class RegisterController extends GetxController {
  Provider provider = Provider();
  AuthRequest authRequest = AuthRequest();

  String name = '';
  String phone = '';
  String password = '';
  String repeatPassword = '';

  Future<void> signUp() async {
    if (isValidateValidSignup()) {
      authRequest.fullName = name;
      authRequest.phone = phone;
      authRequest.password = password;
      provider.auth(
        AuthRequest(),
        requestBody: authRequest,
        onSuccess: (data) {
          Get.offAllNamed(
            AuthRoutes.LOGIN,
          );
          IZIAlert.success(message: "Đăng ký tài khoản thành công");
        },
        onError: (onError) {
          IZIAlert.error(message: "Mã OTP không đúng hoặc hết hạn. Vui lòng thử lại");
          print(" An error occurred while sign up $onError");
        },
      );
      // String phoneOTP = phone;
      // if (phone[0] == '0') {
      //   phoneOTP = phone.substring(1, phone.length);
      // }
      // provider.add(
      //   OTPResponse(),
      //   requestBody: OTPRequest(phone: phoneOTP),
      //   onSuccess: (data) {
      //     autRequest.fullName = name;
      //     autRequest.phone = phone;
      //     autRequest.password = password;
      //     Get.toNamed(
      //       AuthRoutes.VERIFY,
      //       arguments: {
      //         'isRegister': true,
      //         "data": autRequest,
      //       },
      //     );
      //   },
      //   onError: (onError) {
      //     print("An error occurred while get otp $onError");
      //   },
      // );
    }
  }

  ///
  /// Validate sign up
  /// [true] if validate valid
  ///
  /// [false] if validate invalid
  ///
  ///@return bool
  bool isValidateValidSignup() {
    if (IZIValidate.nullOrEmpty(name)) {
      IZIAlert.error(message: "Vui lòng nhập họ và tên");
      return false;
    } else if (IZIValidate.nullOrEmpty(phone)) {
      IZIAlert.error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.phone(phone) != null) {
      IZIAlert.error(message: IZIValidate.phone(phone).toString());
      return false;
    } else if (IZIValidate.nullOrEmpty(password)) {
      IZIAlert.error(message: "Mật khẩu không được để trống");
      return false;
    }
    if (password != repeatPassword) {
      IZIAlert.error(message: "Mật khẩu không trùng khớp");
      return false;
    }
    return true;
  }

  ///
  /// on login button
  ///
  void onToLogin() {
    Get.offAllNamed(AuthRoutes.LOGIN);
  }
}
