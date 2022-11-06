import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import '../../../../base_widget/izi_loader_overlay.dart';
import '../../../../data/model/auth/auth_request.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../provider/auth_provider.dart';
import '../login/login_controller.dart';

class RegisterController extends GetxController {
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  AuthRequest authRequest = AuthRequest();

  String phone = '';
  String password = '';
  String repeatPassword = '';

  List<bool> isValidates = [false,false,false];

  ///
  /// Đăng ký
  ///
  Future<void> signUp() async {
    onShowLoaderOverlay();
    if (isValidateValidSignup()) {
      authRequest.phone = phone;
      authRequest.password = password;
      authRequest.isVerified = true;
      authProvider.register(
        request: authRequest,
        onSuccess: (data) {
          final loginController = Get.find<LoginController>();
          loginController.phone = phone;
          loginController.password = password;
          isValidates = [false,false,false];
          clearForm();
          Get.offAllNamed(
            AuthRoutes.LOGIN,
          );
          IZIAlert.success(message: "Đăng ký tài khoản thành công");
        },
        onError: (onError) {
          // IZIAlert.error(message: "Mã OTP không đúng hoặc hết hạn. Vui lòng thử lại");
          IZIAlert.error(message: "Số điện thoại đã tồn tại vui lòng thử lại");
          onHideLoaderOverlay();
          print(" An error occurred while sign up $onError");
        },
      );
    }else{
      onHideLoaderOverlay();
    }
  }

  ///
  /// clear form
  ///
  void clearForm() {
    phone = '';
    password = '';
    repeatPassword = '';
  }

  ///
  /// Validate sign up
  /// [true] if validate valid
  ///
  /// [false] if validate invalid
  ///
  ///@return bool
  bool isValidateValidSignup() {
    final bool isValidate = isValidates.contains(false);
    return !isValidate;
  }

  ///
  /// on login button
  ///
  void onToLogin() {
    clearForm();
    final loginController = Get.find<LoginController>();
    loginController.phone = phone;
    loginController.password = password;
    
    Get.offAllNamed(
      AuthRoutes.LOGIN,
    );
  }
}
