// ignore_for_file: use_setters_to_change_properties

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/auth_service_apple/auth_service_apple.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/userspecialize_provider.dart';
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/routes/route_path/sign_up_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'dart:io' show Platform;

import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class LoginController extends GetxController {
  /// Declare API.
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final UserSpecializeProvider userSpecializeProvider = GetIt.I.get<UserSpecializeProvider>();
  final DioClient dioClient = GetIt.I.get<DioClient>();
  GoogleSignInAccount? userGoogle;
  User? userIOS;
  Map<String, dynamic> userFacebook = {};

  /// Declare GoogleSignIn.
  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  /// Declare Data.
  bool isLoading = true;
  RxBool isIOS = true.obs;
  RxBool isAvailableFutureAppleSignIn = false.obs;
  RxBool isEnabledButton = true.obs;
  RxBool isEnableButtonPhoneNumber = false.obs;
  RxBool isEnableButtonPassword = false.obs;
  RxString phoneNumber = ''.obs;
  RxString password = ''.obs;
  RxString errorTextPhoneNumber = ''.obs;
  RxString errorTextPassword = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// Check Platform Device.
    _checkPlatform();
  }

  @override
  void dispose() {
    isIOS.close();
    isAvailableFutureAppleSignIn.close();
    isEnabledButton.close();
    isEnableButtonPhoneNumber.close();
    isEnableButtonPassword.close();
    phoneNumber.close();
    password.close();
    errorTextPhoneNumber.close();
    errorTextPassword.close();
    super.dispose();
  }

  ///
  /// Check Platform Device.
  ///
  void _checkPlatform() {
    /// If IOS device then check available Apple login.
    if (Platform.isAndroid) {
      isIOS.value = false;
    } else if (Platform.isIOS) {
      isIOS.value = true;

      /// Check available Apple login.
      _checkAvailableAppleLogin();
    }

    /// Listen when have change on Google sign in.
    _listChangedGoogleSignIn();
  }

  ///
  /// Listen when have change on Google sign in.
  ///
  void _listChangedGoogleSignIn() {
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      userGoogle = account;
      isEnabledButton.value = false;

      /// If have already logger Google then start login to app.
      if (!IZIValidate.nullOrEmpty(userGoogle)) {
        ///
        /// Login to app.
        loginSocial(typeRegister: 2);
      }
    });
    googleSignIn.signInSilently();

    /// Just [update] first load [Login page]..
    if (isLoading) {
      isLoading = false;
      update();
    }
  }

  ///
  /// Sign in with Google.
  ///
  Future<void> signInGoogle() async {
    try {
      await googleSignIn.signIn();
    } catch (error) {
      isEnabledButton.value = true;
    }
  }

  ///
  /// Sign in with Facebook.
  ///
  Future<UserCredential> signInWithFacebook() async {
    /// Trigger the sign-in flow.
    final LoginResult loginResult = await FacebookAuth.instance.login();

    /// Create a credential from the access token.
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    userFacebook = await FacebookAuth.instance.getUserData();

    /// Login Facebook.
    loginSocial(typeRegister: 4);

    /// Once signed in, return the UserCredential.
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  ///
  /// Check Available Apple Login.
  ///
  Future<void> _checkAvailableAppleLogin() async {
    isAvailableFutureAppleSignIn.value = await TheAppleSignIn.isAvailable();
    if (isAvailableFutureAppleSignIn.value == true) {
      TheAppleSignIn.onCredentialRevoked!.listen((data) {});
    }
  }

  ///
  /// Sign in with Apple.
  ///
  Future<void> signInWithApple() async {
    if (isAvailableFutureAppleSignIn.value == true) {
      try {
        final authService = AuthAppleService();

        userIOS = await authService.signInWithApple(scopes: [Scope.email, Scope.fullName]);
        if (!IZIValidate.nullOrEmpty(userIOS)) {
          /// Login to app.
          loginSocial(typeRegister: 3);
        }
      } catch (e) {
        IZIToast().error(message: "please_sign_in_again".tr);
        print(e);
      }
    } else {
      IZIToast().error(message: "the_device_is_unusable".tr);
    }
  }

  ///
  /// Check validate when import phone number.
  ///
  String? onValidatePhoneNumber(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableButtonPhoneNumber.value = false;
      return errorTextPhoneNumber.value = "validate_phone_number_1".tr;
    }
    if (IZIValidate.phoneNumber(phoneNumber.value) == false) {
      isEnableButtonPhoneNumber.value = false;
      return errorTextPhoneNumber.value = "validate_phone_number_2".tr;
    }
    if (phoneNumber.value.length > 10) {
      isEnableButtonPhoneNumber.value = false;
      return errorTextPhoneNumber.value = "validate_phone_number_2".tr;
    }
    isEnableButtonPhoneNumber.value = true;
    return errorTextPhoneNumber.value = "";
  }

  ///
  /// On change value phone number.
  ///
  /// ignore: use_setters_to_change_properties.
  void onChangedValuePhoneNumber(String val) {
    phoneNumber.value = val;
  }

  ///
  /// On validate password.
  ///
  String? onValidatePassword(String val) {
    if (val.length < 6) {
      isEnableButtonPassword.value = false;
      return errorTextPassword.value = 'validate_password_1'.tr;
    }

    isEnableButtonPassword.value = true;
    return errorTextPassword.value = "";
  }

  ///
  /// On change password.
  ///
  void onChangedPassword(String val) {
    password.value = val;
  }

  ///
  /// Generate value enable button.
  ///
  bool genValueEnableButton() {
    if (isEnableButtonPhoneNumber.value == true && isEnableButtonPassword.value == true) {
      return true;
    }
    return false;
  }

  ///
  /// Login to app.
  ///
  Future<void> loginSocial({required int typeRegister}) async {
    EasyLoading.show(status: "please_waiting".tr);

    switch (typeRegister) {

      /// With case = 1 then login app with HaQua account.
      case 1:
        {
          final AuthRequest authRequestHaQua = AuthRequest();
          authRequestHaQua.phone = phoneNumber.value.replaceFirst(RegExp('0'), '');
          authRequestHaQua.password = password.value;
          authRequestHaQua.typeRegister = IZIValidate.getTypeRegisterString(typeRegister);
          authRequestHaQua.deviceId = sl<SharedPreferenceHelper>().getTokenDevice.toString();
          authProvider.loginHaQua(
            request: authRequestHaQua,
            onSuccess: (model) async {
              sl<SharedPreferenceHelper>().setLogin(status: true);
              sl<SharedPreferenceHelper>().setIdUser(model.id.toString());
              await sl<SharedPreferenceHelper>().setJwtToken(model.accessToken.toString());

              /// Reset Dio jwtToken when first time Login App
              await dioClient.resetInit();

              /// Check user have already registered specialize.
              userSpecializeProvider.paginate(
                page: 1,
                limit: 10,
                filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
                onSuccess: (models) {
                  EasyLoading.dismiss();

                  /// If empty then go to [Areas of expertise page] else go to [Home page].
                  if (models.isEmpty) {
                    Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE, arguments: model.typeRegister);
                  } else {
                    Get.offAllNamed(HomeRoutes.DASHBOARD);
                  }
                },
                onError: (error) {
                  IZIToast().error(message: "error_login_2".tr);
                  print(error);
                  EasyLoading.dismiss();
                },
              );
            },
            onError: (error) {
              IZIToast().error(message: "error_login_1".tr);

              print(error);
              EasyLoading.dismiss();
            },
          );
          break;
        }

      /// With case = 2 then login app with Google account.
      case 2:
        {
          final AuthRequest authRequestHaQua = AuthRequest();
          authRequestHaQua.tokenLogin = userGoogle!.id.toString();
          authRequestHaQua.fullName = userGoogle!.displayName.toString();
          authRequestHaQua.avatar = userGoogle!.photoUrl.toString();
          authRequestHaQua.typeRegister = IZIValidate.getTypeRegisterString(typeRegister);
          authRequestHaQua.deviceId = sl<SharedPreferenceHelper>().getTokenDevice.toString();

          authProvider.loginSocial(
            request: authRequestHaQua,
            onSuccess: (model) async {
              print("Token Login ${model.accessToken}");
              sl<SharedPreferenceHelper>().setLogin(status: true);
              sl<SharedPreferenceHelper>().setIdUser(model.id.toString());
              await sl<SharedPreferenceHelper>().setJwtToken(model.accessToken.toString());

              /// Reset Dio jwtToken when first time Login App
              await dioClient.resetInit();

              /// Check user have already registered specialize.
              userSpecializeProvider.paginate(
                page: 1,
                limit: 10,
                filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
                onSuccess: (models) {
                  EasyLoading.dismiss();

                  /// If empty then go to [Areas of expertise page] else go to [Home page].
                  if (models.isEmpty) {
                    Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE, arguments: model.typeRegister);
                  } else {
                    Get.offAllNamed(HomeRoutes.DASHBOARD);
                  }
                },
                onError: (error) {
                  IZIToast().error(message: "error_login_2".tr);
                  print(error);
                  EasyLoading.dismiss();
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
          break;
        }

      /// With case = 3 then login app with Apple account.
      case 3:
        {
          final AuthRequest authRequestHaQua = AuthRequest();
          authRequestHaQua.tokenLogin = userIOS!.uid.toString();
          authRequestHaQua.fullName = userIOS!.displayName.toString();
          authRequestHaQua.avatar = userIOS!.photoURL.toString();
          authRequestHaQua.typeRegister = IZIValidate.getTypeRegisterString(typeRegister);
          authRequestHaQua.deviceId = sl<SharedPreferenceHelper>().getTokenDevice.toString();
          authProvider.loginSocial(
            request: authRequestHaQua,
            onSuccess: (model) async {
              print("Token Login ${model.accessToken}");
              sl<SharedPreferenceHelper>().setLogin(status: true);
              sl<SharedPreferenceHelper>().setIdUser(model.id.toString());
              await sl<SharedPreferenceHelper>().setJwtToken(model.accessToken.toString());

              /// Reset Dio jwtToken when first time Login App
              await dioClient.resetInit();

              /// Check user have already registered specialize.
              userSpecializeProvider.paginate(
                page: 1,
                limit: 10,
                filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
                onSuccess: (models) {
                  EasyLoading.dismiss();

                  /// If empty then go to [Areas of expertise page] else go to [Home page].
                  if (models.isEmpty) {
                    Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE, arguments: model.typeRegister);
                  } else {
                    Get.offAllNamed(HomeRoutes.DASHBOARD);
                  }
                },
                onError: (error) {
                  IZIToast().error(message: "error_login_2".tr);
                  print(error);
                  EasyLoading.dismiss();
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
          break;
        }

      /// With case = 4 then login app with Facebook account.
      case 4:
        {
          final AuthRequest authRequestHaQua = AuthRequest();
          authRequestHaQua.tokenLogin = userFacebook['id'].toString();
          authRequestHaQua.fullName = userFacebook['name'].toString();
          authRequestHaQua.avatar = userFacebook['picture']['data']['url'].toString();
          authRequestHaQua.typeRegister = IZIValidate.getTypeRegisterString(typeRegister);
          authRequestHaQua.deviceId = sl<SharedPreferenceHelper>().getTokenDevice.toString();
          authProvider.loginSocial(
            request: authRequestHaQua,
            onSuccess: (model) async {
              print("Token Login ${model.accessToken}");
              sl<SharedPreferenceHelper>().setLogin(status: true);
              sl<SharedPreferenceHelper>().setIdUser(model.id.toString());
              await sl<SharedPreferenceHelper>().setJwtToken(model.accessToken.toString());

              /// Reset Dio jwtToken when first time Login App
              await dioClient.resetInit();

              /// Check user have already registered specialize.
              userSpecializeProvider.paginate(
                page: 1,
                limit: 10,
                filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
                onSuccess: (models) {
                  EasyLoading.dismiss();

                  /// If empty then go to [Areas of expertise page] else go to [Home page].
                  if (models.isEmpty) {
                    Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE, arguments: model.typeRegister);
                  } else {
                    Get.offAllNamed(HomeRoutes.DASHBOARD);
                  }
                },
                onError: (error) {
                  IZIToast().error(message: "error_login_2".tr);
                  print(error);
                  EasyLoading.dismiss();
                },
              );
            },
            onError: (error) {
              print(error);
            },
          );
          break;
        }

      default:
    }
  }

  ///
  /// Go to [Home page].
  ///
  void gotToHomePage() {
    Get.toNamed(HomeRoutes.DASHBOARD);
  }

  ///
  /// Go to [Sign up page].
  ///
  void goToSignUpPage() {
    Get.toNamed(SignUpRoutes.SIGN_UP);
  }

  ///
  /// Go to [Forgot password page].
  ///
  void goToForgotPassword() {
    // Get.toNamed(LoginRoutes.FORGOT_PASS);
  }
}
