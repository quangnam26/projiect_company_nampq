import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/auth/login_request.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';

import '../../../../data/model/auth/auth_request.dart';
import '../../../../data/model/provider/provider.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class LoginController extends GetxController {
  final Provider provider = Provider();
  final DioClient? dioClient = GetIt.I.get<DioClient>();

  bool isRememberPassword = false;

  //Variables
  String phone = '';
  String password = '';

  @override
  void onInit() {
    super.onInit();
    isRememberPassword = false;
  }

  ///
  /// Changed radio button save password
  ///
  void onChangedSavePassword() {
    isRememberPassword = !isRememberPassword;
    sl<SharedPreferenceHelper>().setRemember(remember: isRememberPassword);
    print(sl<SharedPreferenceHelper>().getRemember);
    update();
  }

  ///
  /// on login button
  ///
  void onLogin() {
    if (isValidateValidLogin()) {
      onSignIn();
    }
  }

  ///
  /// on sign in
  ///
  void onSignIn() {
    EasyLoading.show(status: "Đăng nhập ...");
    final LoginRequest loginRequest = LoginRequest();
    loginRequest.phone = phone;
    loginRequest.password = password;
    provider.auth(
      AuthResponse(),
      requestBody: loginRequest,
      onSuccess: (data) async {
        IZIAlert.success(message: "Đăng nhập thành công");
        final account = data as AuthResponse;
        if (!IZIValidate.nullOrEmpty(account)) {
          sl<SharedPreferenceHelper>().setJwtToken(account.accessToken.toString());
          await dioClient!.refreshToken();
          if (!IZIValidate.nullOrEmpty(account.user)) {
            sl<SharedPreferenceHelper>().setProfile(account.user!.id.toString());
            updateDeviceToken(account.user!.id.toString());
          }

          onGoToHomePage();
        }

        EasyLoading.dismiss();
      },
      onError: (onError) {
        IZIAlert.error(message: "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
        print("An error has occurred while trying to login $onError");
        EasyLoading.dismiss();
      },
    );
  }

  ///
  /// update device token
  ///
  Future<void> updateDeviceToken(String idUser) async {
    final firebase = FirebaseMessaging.instance;
    final AuthRequest authRequest = AuthRequest();
    authRequest.fcmToken = Platform.isIOS ? await firebase.getAPNSToken() : await firebase.getToken();
    provider.update(
      UserRequest(),
      id: idUser,
      requestBody: authRequest,
      onSuccess: (data) {},
      onError: (onError) {
        print("An error has occurred while update user $onError");
      },
    );
  }

  ///
  /// Validate login
  /// [true] if validate valid
  ///
  /// [false] if validate invalid
  ///
  ///@return bool
  bool isValidateValidLogin() {
    if (IZIValidate.nullOrEmpty(phone)) {
      IZIAlert.error(message: "Số điện thoại không được để trống");
      return false;
    } else if (IZIValidate.phone(phone) != null) {
      IZIAlert.error(message: IZIValidate.phone(phone).toString());
      return false;
    } else if (IZIValidate.nullOrEmpty(password)) {
      IZIAlert.error(message: "Mật khẩu không được để trống");
      return false;
    }
    return true;
  }

  ///
  /// go to home page
  ///
  void onGoToHomePage() {
    Get.offAllNamed(SplashRoutes.HOME);
  }

  ///
  /// on forget password button
  ///
  void onForgetPassword() {
    Get.toNamed(AuthRoutes.FORGET_PASSWORD);
  }

  ///
  /// on forget password button
  ///
  void onRegister() {
    Get.toNamed(AuthRoutes.REGISTER);
  }
}
