import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import '../../../../base_widget/izi_loader_overlay.dart';
import '../../../../data/model/auth/auth_request.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

enum ACCOUNT {
  GOOGLE,
  FACEBOOK,
  DPFOOD,
}

class LoginController extends GetxController {
  // final Provider provider = Provider();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  //OAth

  //116247700198345745827

  bool isRememberPassword = false;
  // bool termsAndPolicy = false;
  bool showTerms = false;

  //Variables
  String phone = '';
  String password = '';
  AuthRequest? authRequest;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '116247700198345745827',
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
    // serverClientId: ...,
  );

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
    update();
  }

  ///
  /// on login button
  ///
  void onLogin(ACCOUNT account) {
    onShowLoaderOverlay();
    if (account == ACCOUNT.DPFOOD) {
      if (isValidateValidLogin()) {
        onSignIn();
      } else {
        onHideLoaderOverlay();
      }
    } else if (account == ACCOUNT.GOOGLE) {
      _handleSignIn();
    } else {
      _handleSignInFacebook();
    }
    sl<SharedPreferenceHelper>()
        .setAccountType(ACCOUNT.values.indexOf(account));
  }

  ///
  /// Login with google
  ///
  Future<void> _handleSignIn() async {
    try {
      print(await _googleSignIn.isSignedIn());
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      // print("Account: $account");
      // print('ID: ${account!.id}');
      // print('Email: ${account.email}');
      if (account != null) {
        sl<SharedPreferenceHelper>().setProfile(account.id.toString());
        onGoToHomePage();
        onHideLoaderOverlay();
      }
    } catch (error) {
      print("An occurred error while login google $error");
      onHideLoaderOverlay();
    }
  }

  ///
  /// Login with facebook
  ///
  Future<void> _handleSignInFacebook() async {
    try {} catch (error) {
      print("An occurred error while login google $error");
    }
  }

  ///
  /// on sign in
  ///
  Future<void> onSignIn() async {
    final AuthRequest loginRequest = AuthRequest();
    loginRequest.phone = phone;
    loginRequest.password = password;
    // final firebase = FirebaseMessaging.instance;
    // loginRequest.fcmToken = Platform.isIOS ? await firebase.getAPNSToken() : await firebase.getToken();
    authProvider.signin(
      request: loginRequest,
      onSuccess: (account) async {
        if (!IZIValidate.nullOrEmpty(account)) {
          if (account.user!.typeUser != '0') {
            IZIAlert.error(
                message:
                    "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
            onHideLoaderOverlay();
            return;
          }
          IZIAlert.success(message: "Đăng nhập thành công");
          sl<SharedPreferenceHelper>()
              .setJwtToken(account.accessToken.toString());
          sl<SharedPreferenceHelper>()
              .setRefreshToken(account.refreshToken.toString());
          await dioClient!.refreshToken();
          if (!IZIValidate.nullOrEmpty(account.user)) {
            sl<SharedPreferenceHelper>()
                .setProfile(account.user!.id.toString());
          }
          phone = '';
          password = '';
          onHideLoaderOverlay();
          onGoToHomePage();
        }
        EasyLoading.dismiss();
      },
      onError: (onError) {
        IZIAlert.error(
            message: "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
        onHideLoaderOverlay();
        print("An error has occurred while trying to login $onError");
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
  /// go to  page
  ///
  void onGoToHomePage() {
    Get.offAllNamed(SplashRoutes.HOME,
        predicate: ModalRoute.withName(SplashRoutes.HOME));
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
