import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/auth/otp_request.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
// import 'package:template/routes/route_path/auth_routes.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../../base_widget/izi_loader_overlay.dart';
import '../../../../data/datasource/remote/dio/dio_client.dart';
import '../../../../data/model/auth/auth_request.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../routes/route_path/splash_routes.dart';
import '../../../../utils/app_constants.dart';

enum Account {
  GOOGLE,
  FACEBOOK,
}

class RegisterController extends GetxController {
  // Provider provider = Provider();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  AuthRequest authRequest = AuthRequest();
  AuthResponse authResponse = AuthResponse();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: clientId,
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String name = '';
  String phone = '';
  String password = '';
  String repeatPassword = '';
  bool isLoading = true;

  Future<void> signUp() async {
    if (isValidateValidSignup()) {
      authRequest.fullName = name;
      authRequest.phone = phone.replaceFirst(RegExp('0'), '').toString();
      authRequest.password = password;
      authRequest.deviceID = sl<SharedPreferenceHelper>().getTokenDevice;
      final OTPRequest otpRequest = OTPRequest();
      otpRequest.phone = authRequest.phone;
      authProvider.sendOTP(
          phone: otpRequest,
          onSuccess: (data) {
            // print(data);
            authRequest.otpCode = data;

            authProvider.register(
                request: authRequest,
                onSuccess: (onSuccess) {
                  IZIAlert.success(message: "Đăng ký tài khoản thành công");
                  onToLogin();

                  // Get.back(result: {"phone": phone, "password": password});
                },
                onError: (onError) {
                  IZIAlert.success(
                      message: "Tài khoản đã tồn tại",
                      backgroundColor: Colors.red);
                });
          },
          onError: (err) {});
    }
  }

  ///
  /// HandleSignIn
  ///
  Future<void> handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        loginSocial(accountType: "GOOGLE", idSocial: account.id);
        print("idGoogle: ${account.id}");
      }
    } catch (error) {
      print("An occurred error while login google $error");
      onHideLoaderOverlay();
    }
  }

  ///
  /// loginSocial
  ///
  void loginSocial({required String accountType, required String idSocial}) {
    EasyLoading.show(status: "please waiting");
    authRequest.typeRegister = accountType.toString();
    authRequest.tokenLogin = idSocial;

    authProvider.signinWithSocial(
      request: authRequest,
      onSuccess: (onSuccess) {
        IZIAlert.success(message: "Đăng Ký thành công");
        handleSaveAccountLoggned(account: onSuccess);
        EasyLoading.dismiss();
        onGoToHomePage();
        // Get.toNamed(AU, arguments: model.typeRegister);

        print("thanh cong  $onSuccess");
      },
      onError: (onError) {
        IZIAlert.error(
            message: "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
        onHideLoaderOverlay();
        print("An occurred error while login google $onError");
      },
    );
  }

  Future<void> handleSignInApple() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      if (credential.userIdentifier != null) {
        // loginSocial(accountType: accountType, idSocial: credential.userIdentifier.toString());
        loginApple(
            accountType: 'APPLE',
            idSocial: credential.userIdentifier.toString());
      }
      onHideLoaderOverlay();
    } catch (error) {
      onHideLoaderOverlay();
      print("An occurred error while login apple $error");
    }
  }

  ///
  /// Sign with Apple
  ///
  void loginApple({required String accountType, required String idSocial}) {
    EasyLoading.show(status: "please_waiting".tr);
    authRequest.typeRegister = accountType.toString();
    authRequest.tokenLogin = idSocial;
    authProvider.signinWithSocial(
      request: authRequest,
      onSuccess: (onSuccess) {
        // clearForm();
        authResponse = onSuccess;
        IZIAlert.success(message: "Đăng nhập thành công");
        handleSaveAccountLoggned(account: onSuccess);
        EasyLoading.dismiss();
        Get.offAllNamed(SplashRoutes.HOME);
      },
      onError: (onError) {
        IZIAlert.error(
            message: "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
        onHideLoaderOverlay();
        print("An occurred error while login google $onError");
      },
    );
  }

  ///
  /// go to  page
  ///
  void onGoToHomePage() {
    Get.offAllNamed(
      SplashRoutes.HOME,
      predicate: ModalRoute.withName(SplashRoutes.HOME),
    );
    Get.back();
  }

  ///
  /// Handle save infomation account loggined
  ///
  Future<void> handleSaveAccountLoggned({required AuthResponse account}) async {
    sl<SharedPreferenceHelper>().setJwtToken(account.accessToken.toString());
    sl<SharedPreferenceHelper>()
        .setRefreshToken(account.refreshToken.toString());
    await dioClient!.refreshToken();

    sl<SharedPreferenceHelper>().setLogin(status: true);

    if (!IZIValidate.nullOrEmpty(account.user)) {
      sl<SharedPreferenceHelper>().setProfile(account.user!.id.toString());
    }

    await GetIt.I.get<DioClient>().refreshToken();
  }

  /// clear form
  ///
  void clearForm() {
    name = '';
    phone = '';
    password = '';
    repeatPassword = '';
  }

  ///
  ///isValidateValidSignup
  ///
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
    // clearForm();
    // final loginController = Get.find<LoginController>();
    // loginController.phone = phone;
    // loginController.password = password;

    Get.back(result: {
      "phone": phone,
      "password": password,
    });
  }
}
