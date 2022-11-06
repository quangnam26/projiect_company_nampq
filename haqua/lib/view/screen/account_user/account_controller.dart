import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/account_routers.dart';
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/routes/route_path/login_routers.dart';
import 'package:template/routes/route_path/sign_up_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class AccountController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  Rx<UserResponse> userResponse = UserResponse().obs;

  /// Declare Data.
  GoogleSignIn googleSignIn = GoogleSignIn(
    // Optional clientId
    // clientId: '479882132969-9i9aqik3jfjd7qhci1nqf0bm2g71rm1u.apps.googleusercontent.com',
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  bool isLoading = true;
  bool isLogin = false;
  RxBool isSwitch = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Call API get data user by id.
    getUserById();
  }

  @override
  void dispose() {
    isSwitch.close();
    userResponse.close();
    super.dispose();
  }

  ///
  /// Call API get data user by id.
  ///
  void getUserById() {
    isLogin = sl<SharedPreferenceHelper>().getLogin;
    googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {});
    googleSignIn.signInSilently();

    if (isLogin == false) {
      isLoading = false;
      update();
    } else {
      userProvider.find(
        id: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (onSuccess) {
          userResponse.value = onSuccess;
          isSwitch.value = userResponse.value.enableFCM!;

          /// Just [update] first load [Account page].
          if (isLoading) {
            isLoading = false;
            update();
          }
        },
        onError: (onError) {
          print(onError);
        },
      );
    }
  }

  ///
  /// On/Off receive notices.
  ///
  void switchButtonNotify({bool value = false}) {
    isSwitch.value = value;
    final UserRequest userRequest = UserRequest();
    userRequest.enableFCM = isSwitch.value;
    userProvider.changeStatusFCM(
      data: userRequest,
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse.value = model;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Go to [Account page].
  ///
  void navigatorAccountMenu({required String appRouter}) {
    Get.toNamed(appRouter);
  }

  ///
  /// Go to [Info user page].
  ///
  void goToInfoUser() {
    Get.toNamed(AccountRouter.INFORACCOUNT)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value)) {
        userResponse.value = value as UserResponse;
      }
    });
  }

  ///
  /// Go to [Areas of Expertise page].
  ///
  void goToAreasOfExpertise() {
    Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE, arguments: "1");
  }

  ///
  /// On delete account.
  ///
  void deleteAccount() {
    IZIDialog.showDialog(
      lable: "tilte_dialog_del_acc".tr,
      description: "content_dialog_del_acc".tr,
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        userProvider.delete(
          id: sl<SharedPreferenceHelper>().getIdUser,
          onSuccess: (models) {
            Get.offNamed(
              LoginRoutes.LOGIN,
            );
          },
          onError: (error) {
            print(error);
          },
        );
      },
    );
  }

  ///
  /// Log out account.
  ///
  void logOut() {
    /// Remove SharedPreferenceHelper when log out account.
    sl<SharedPreferenceHelper>().removeJWTToken();
    sl<SharedPreferenceHelper>().removeLogin();
    sl<SharedPreferenceHelper>().removeIdUser();
    if (userResponse.value.typeRegister.toString().toLowerCase() == GOOGLE) {
      googleSignIn.disconnect();
    }
    Get.offNamed(
      LoginRoutes.LOGIN,
    );
  }

  ///
  /// On sign up for guest account and go to [Sign up page].
  ///
  void signUpFromGuestAccount() {
    Get.toNamed(SignUpRoutes.SIGN_UP, arguments: 2);
  }

  ///
  /// On go to [Login page] for guest account.
  ///
  void loginFromGuestAccount() {
    Get.offNamed(LoginRoutes.LOGIN);
  }
}
