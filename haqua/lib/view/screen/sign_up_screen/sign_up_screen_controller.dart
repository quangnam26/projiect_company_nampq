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
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/routes/route_path/otp_screen_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'dart:io' show Platform;
import 'package:the_apple_sign_in/the_apple_sign_in.dart';
import '../../../helper/izi_number.dart';
import '../../../provider/userspecialize_provider.dart';
import '../../../routes/route_path/home_routers.dart';
import '../../../routes/route_path/login_routers.dart';

class SignUpController extends GetxController {
  /// Declare API
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final UserSpecializeProvider userSpecializeProvider = GetIt.I.get<UserSpecializeProvider>();
  final DioClient dioClient = GetIt.I.get<DioClient>();
  GoogleSignInAccount? userGoogle;
  User? userIOS;
  Map<String, dynamic> userFacebook = {};

  //Declare Data
  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  bool isLoading = true;
  RxBool isAvailableFutureAppleSignIn = false.obs;
  RxBool isEnabledButton = true.obs;
  RxBool isIOS = true.obs;
  RxBool isEnableButtonPhoneNumber = false.obs;
  RxBool isEnableButtonName = false.obs;
  RxBool isEnableButtonPassword = false.obs;
  RxBool isEnableButtonConfirmPassword = false.obs;
  RxString phoneNumber = ''.obs;
  RxString fullName = ''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxString errorTextPhoneNumber = ''.obs;
  RxString errorTextName = ''.obs;
  RxString errorTextPassword = ''.obs;
  RxString errorTextConfirmPassword = ''.obs;
  RxInt isValueBack = 1.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get Argument Form Before Screen.
    getArgument();
  }

  @override
  void dispose() {
    isAvailableFutureAppleSignIn.close();
    isEnabledButton.close();
    isIOS.close();
    isEnableButtonPhoneNumber.close();
    isEnableButtonName.close();
    isEnableButtonPassword.close();
    isEnableButtonConfirmPassword.close();
    phoneNumber.close();
    fullName.close();
    password.close();
    confirmPassword.close();
    errorTextPhoneNumber.close();
    errorTextName.close();
    errorTextPassword.close();
    errorTextConfirmPassword.close();
    isValueBack.close();
    super.dispose();
  }

  ///
  /// Get Argument Form Before Screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      isValueBack.value = IZINumber.parseInt(Get.arguments);
    }

    /// Check Platform Device.
    checkPlatform();
  }

  ///
  /// Check Platform Device.
  ///
  void checkPlatform() {
    /// If IOS device then check available Apple login.
    if (Platform.isAndroid) {
      isIOS.value = false;
    } else if (Platform.isIOS) {
      isIOS.value = true;

      /// Check available Apple login.
      checkAvailableAppleLogin();
    }

    /// Listen when have change on Google sign in.
    listChangedGoogleSignIn();
  }

  ///
  /// Listen when have change on Google sign in.
  ///
  void listChangedGoogleSignIn() {
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

    /// Just [update] first load [Sign up page].
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
  Future<void> checkAvailableAppleLogin() async {
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
  /// On validate when import phone number.
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
  /// On change when import phone number.
  ///
  // ignore: use_setters_to_change_properties.
  void onChangedValuePhoneNumber(String val) {
    phoneNumber.value = val;
  }

  ///
  /// On validate when import name.
  ///
  String? onValidateName(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableButtonName.value = false;

      return errorTextName.value = "validate_name_1".tr;
    }
    if (val.length < 3) {
      isEnableButtonName.value = false;

      return errorTextName.value = "validate_name_2".tr;
    }
    if (val.length > 27) {
      isEnableButtonName.value = false;

      return errorTextName.value = "validate_name_3".tr;
    }
    isEnableButtonName.value = true;

    return errorTextName.value = "";
  }

  ///
  /// On change when import name.
  ///
  void onChangedValueName(String val) {
    fullName.value = val;
  }

  ///
  /// On validate when import password.
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
  /// On change when import password.
  ///
  void onChangedPassword(String val) {
    password.value = val;
  }

  ///
  /// On validate when import password.
  ///
  String? onValidateConfirmPassword(String val) {
    if (confirmPassword != password) {
      isEnableButtonConfirmPassword.value = false;

      return errorTextConfirmPassword.value = 'validate_password_6'.tr;
    }

    isEnableButtonConfirmPassword.value = true;

    return errorTextConfirmPassword.value = "";
  }

  ///
  /// On change when import password.
  ///
  void onChangedConfirmPassword(String val) {
    confirmPassword.value = val;
  }

  ///
  /// Generate value enable button
  ///
  bool genValueEnableButton() {
    if (isEnableButtonPhoneNumber.value == true && isEnableButtonName.value == true && isEnableButtonPassword.value == true && isEnableButtonConfirmPassword.value == true) {
      return true;
    }
    return false;
  }

  ///
  /// Login with HaQua
  ///
  void loginHaQua() {
    /// If isValueBack == then Get.back else go to [Login page].
    if (isValueBack.value == 1) {
      Get.back();
    } else {
      Get.toNamed(LoginRoutes.LOGIN);
    }
  }

  ///
  /// Login HaQua app with type login.
  ///
  void loginSocial({required int typeRegister}) {
    EasyLoading.show(status: "please_waiting".tr);

    switch (typeRegister) {

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
  /// Go to [OTP page].
  ///
  void goToOTPScreen() {
    /// Disable button for purpose one click.
    isEnableButtonPhoneNumber.value = false;
    final AuthRequest authRequestHaQua = AuthRequest();
    authRequestHaQua.phone = phoneNumber.value.replaceFirst(RegExp('0'), '');
    authRequestHaQua.fullName = fullName.value;
    authRequestHaQua.password = password.value;
    Get.toNamed(OTPScreenRoutes.OTP_SCREEN, arguments: authRequestHaQua)!.then((value) {
      ///
      /// When back again then enable button again.
      isEnableButtonPhoneNumber.value = true;
    });
  }
}
