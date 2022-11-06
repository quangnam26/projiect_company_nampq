import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import '../../../../base_widget/izi_loader_overlay.dart';
import '../../../../data/model/auth/auth_request.dart';
import '../../../../data/model/auth/auth_response.dart';
import '../../../../data/model/provider/provider.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../sharedpref/shared_preference_helper.dart';
import '../../../../utils/app_constants.dart';

class LoginController extends GetxController {
  /// khai bao API
  final Provider provider = Provider();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final DioClient? dioClient = GetIt.I.get<DioClient>();

  AuthResponse authResponse = AuthResponse();
  AuthRequest authRequest = AuthRequest();

  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: clientId,
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

//List
  Map<String, dynamic> userFacebook = {};
//Khai báo biến
  bool isRememberPassword = false;
  bool termsAndPolicy = false;
  bool showTerms = false;
  String phone = '';
  String password = '';

  @override
  void onInit() {
    _checkIsLogin();
    super.onInit();
    isRememberPassword = false;
    termsAndPolicy = sl<SharedPreferenceHelper>().termsAndPolicy;
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
  /// Changed radio button save password
  ///
  void acceptTermsAndPolicy() {
    termsAndPolicy = !termsAndPolicy;
    sl<SharedPreferenceHelper>()
        .setTermsAndPolicy(termsAndPolicy: termsAndPolicy);
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
  Future<void> onSignIn() async {
    final AuthRequest loginRequest = AuthRequest();
    loginRequest.phone = phone.replaceFirst(RegExp('0'), '').toString();
    loginRequest.password = password;
    // final firebase = FirebaseMessaging.instance;
    // loginRequest.fcmToken = Platform.isIOS ? await firebase.getAPNSToken() : await firebase.getToken();
    EasyLoading.show(status: "please waiting");
    authProvider.signin(
      request: loginRequest,
      onSuccess: (account) async {
        if (!IZIValidate.nullOrEmpty(account)) {
          IZIAlert.success(message: "Đăng nhập thành công");
          sl<SharedPreferenceHelper>()
              .setJwtToken(account.accessToken.toString());
          sl<SharedPreferenceHelper>()
              .setRefreshToken(account.refreshToken.toString());
          sl<SharedPreferenceHelper>().setLogin(status: true);
          if (!IZIValidate.nullOrEmpty(account.user)) {
            sl<SharedPreferenceHelper>()
                .setProfile(account.user!.id.toString());
            print('check id User ${sl<SharedPreferenceHelper>().getProfile}');

            await dioClient!.refreshToken();

            phone = '';
            password = '';
            // onHideLoaderOverlay();
            onGoToHomePage();
          }
        }
        EasyLoading.dismiss();
      },
      onError: (onError) {
        IZIAlert.error(
            message: "Tài khoản hoặc mật khẩu không đúng. Vui lòng thử lại");
        // onHideLoaderOverlay();
        print("An error has occurred while trying to login $onError");
        EasyLoading.dismiss();
      },
    );

    // onGoToHomePage();
    return;
  }

  ///
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
    Get.toNamed(SplashRoutes.FORGET_PASSWORD);
  }

  ///
  /// on forget password button
  ///
  void onRegister() {
    Get.toNamed(SplashRoutes.REGISTER)!.then((value) {
      phone = value['phone'].toString();
      password = value['password'].toString();
      update();
      return value;
    });
  }

  ///
  /// checkIsLogin
  ///
  void _checkIsLogin() {
    final language = sl<SharedPreferenceHelper>().getLanguage;
    if (!IZIValidate.nullOrEmpty(language) && language == 'vi') {
      // locale = 'vietnamese'.tr;
    } else {
      // locale = 'english'.tr;
    }
    final isLogin = sl<SharedPreferenceHelper>().getLogin;
    if (!IZIValidate.nullOrEmpty(isLogin) && isLogin == true) {
      Future.delayed(Duration.zero, () async {
        Get.offAllNamed(SplashRoutes.HOME);
      });
    }
    // isLoading = false;
    update();
  }

  ///
  /// Sign in with Facebook.
  ///
  Future<UserCredential?> signInWithFacebook() async {
    /// Trigger the sign-in flow.

    final LoginResult loginResult = await FacebookAuth.instance.login();
    print(loginResult);
    if (loginResult.status == LoginStatus.success) {
      /// Create a credential from the access token.
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      userFacebook = await FacebookAuth.instance.getUserData();
      loginSocial(
          accountType: "FACEBOOK", idSocial: userFacebook['id'].toString());

      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      print(loginResult.status);
      print(loginResult.message);

      return null;
    }

    /// Once signed in, return the UserCredential.
  }

  ///
  ///Sign google
  ///
  Future<void> handleSignIn() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        loginSocial(accountType: "GOOGLE", idSocial: account.id);
      }
    } catch (error) {
      print(" lôix google  $error");
      // onHideLoaderOverlay();
    }
  }

  ///
  /// Sign with Google
  ///
  void loginSocial({required String accountType, required String idSocial}) {
    EasyLoading.show(status: "please waiting".tr);
    authRequest.typeRegister = accountType.toString();
    authRequest.tokenLogin = idSocial;
    authProvider.signinWithSocial(
      request: authRequest,
      onSuccess: (onSuccess) async {
        IZIAlert.success(message: "Đăng nhập thành công");
        await handleSaveAccountLoggned(account: onSuccess);
        EasyLoading.dismiss();

        onGoToHomePage1();
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
  void onGoToHomePage1() {
    Get.offAllNamed(SplashRoutes.HOME);
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
    print('Phone 2');
  }

  ///
  /// Login with apple
  ///
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
        onGoToHomePage1();
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
  /// go to home screen
  ///
  void gotoHomScreen() {
    Get.offAllNamed(SplashRoutes.HOME);
  }
}
