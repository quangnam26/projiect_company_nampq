// ignore_for_file: unrelated_type_equality_checks
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/routes/route_path/change_the_password_routes.dart';
import 'package:template/routes/route_path/contact_routes.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/cart_router.dart';
import 'package:template/routes/route_path/chat_routes.dart';
import 'package:template/routes/route_path/hunting_vouchers_routes.dart';
import 'package:template/routes/route_path/order_router.dart';
import 'package:template/routes/route_path/other_policies_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/routes/route_path/wallet_routes.dart';
import '../../../base_widget/izi_dialog.dart';
import '../../../data/model/setting/setting_response.dart';
import '../../../di_container.dart';
import '../../../helper/izi_alert.dart';
import '../../../provider/settings_provider.dart';
import '../../../routes/route_path/order_router.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/app_constants.dart';
import '../dash_board/dash_board_controller.dart';

class AccountController extends GetxController {
  // khai báo data
  final SettingsProvider settingsProvider = GetIt.I.get<SettingsProvider>();
  AuthResponse authResponse = AuthResponse();
  AuthRequest authRequest = AuthRequest();
  AuthProvider authProvider = AuthProvider();

  GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: clientId,
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

//List
  List<Map<String, dynamic>> menusAccount = [];
  SettingResponse settingResponse = SettingResponse();
  List<SettingResponse> listSetting = [];

//khai báo biến
  bool deboll = false;
  String idUser = sl<SharedPreferenceHelper>().getProfile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataSettings();
    menusAccount = [
      {
        'title': 'Thông tin cá nhân',
        'image': 'assets/images/user.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(AccountRoutes.PERSONAL_INFORMATION);
        },
      },
      {
        'title': 'ví của tôi',
        'image': 'assets/icons/ic_mywallet.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(WalletRouters.WALLET_MONEY);
        },
      },
      {
        'title': 'Địa chỉ nhận hàng',
        'image': 'assets/icons/ic_location.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(CartRoutes.ADDRESS_DELIVERY);
        },
      },
      {
        'title': 'Đơn hàng của tôi',
        'image': 'assets/icons/ic_shopping_cart.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(OrderRoutes.ORDER);
        },
      },
      {
        'title': 'Ưu đãi mã mua hàng',
        'image': 'assets/icons/ic_bag.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(HuntingVouchersRoutes.HUNTING_VOUCHERS,
                  arguments: "data");
        },
      },
      {
        'title': 'Thay đổi mật khẩu',
        'image': 'assets/icons/ic_briefcase.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(ChangeThePassWordRoutes.CHANGE_THE_PASSWORD);
        },
      },
      {
        'title': 'Tổng đài tư vấn',
        'image': 'assets/icons/ic_user.png',
        'onTap': () {
          // Get.toNamed(AccountRoutes.CONSULTATION_CALL_CENTER);
          clickCallTheSwitchboard();
        },
      },
      {
        'title': 'Liên hệ',
        'image': 'assets/icons/ic_sms.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(ContactRoutes.CONTACT);
        },
      },
      {
        'title': 'Hỗ trợ',
        'image': 'assets/icons/ic_message.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(ChatRoutes.CHAT);
        },
      },
      {
        'title': 'Các chính sách khác',
        'image': 'assets/icons/ic_shoppe.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : Get.toNamed(OtherPoliciesRoutes.OTHER_POLICIES);
        },
      },
      {
        'title': 'Đăng xuất',
        'image': 'assets/icons/ic_logout.png',
        'onTap': () {
          IZIValidate.nullOrEmpty(idUser)
              ? Get.find<DashBoardController>().checkLogin()
              : logout();
        },
      },
    ];
    update();
  }

  ///
  ///getDataSettings
  ///
  void getDataSettings() {
    settingsProvider.all(
      onSuccess: (onSuccess) {
        listSetting = onSuccess;
        settingResponse = listSetting.first;
        update();
      },
      onError: (onError) {},
    );
  }

  ///
  /// clickCallTheSwitchboard(gọi điện tư vấn)
  ///
  void clickCallTheSwitchboard() {
    IZIDialog.showDialog(
      confirmLabel: "Đồng ý gọi",
      description: "0${settingResponse.hotline ?? ""} ",
      lable: 'Số điện thoại tổng đài viên',
      onConfirm: () async {
        final Uri launchUri =
            Uri(scheme: 'tel', path: "0${settingResponse.hotline}");
        // ignore: deprecated_member_use
        if (await canLaunch(launchUri.toString())) {
          // ignore: deprecated_member_use
          await launch(launchUri.toString());
        } else {
          IZIAlert.success(message: "số điện thoại bị lỗi");
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  ///
  ///logout (Đăng xuất)
  ///
  void logout() async {
    EasyLoading.show(status: "please waiting");
    await Future.delayed(
      const Duration(milliseconds: 2000),
      () {
        sl<SharedPreferenceHelper>().removeJWTToken();
        sl<SharedPreferenceHelper>().removeLogin();
        sl<SharedPreferenceHelper>().removeIdUser();
        sl<SharedPreferenceHelper>().setProfile('');
        // googleSignIn.signOut();
        // if (authResponse.typeRegister.toString().toLowerCase() == 'GOOGLE') {
        // googleSignIn.disconnect();
    //     Future<GoogleSignInAccount?> signOut() =>
    // _addMethodCall(GoogleSignInPlatform.instance.signOut)
    googleSignIn.disconnect();
FirebaseAuth.instance.signOut();
        // }
        // await FacebookAuth.instance.logOut();

        EasyLoading.dismiss();
        IZIAlert.success(message: "Đăng xuất thành công");

        Get.offAllNamed(SplashRoutes.LOGIN);
        update();
      },
    );
  }

  // void logOut() {
  //   authProvider.postLogOut(
  //     data: AuthRequest(deviceID: sl<SharedPreferenceHelper>().getTokenDevice),
  //     onSuccess: (onSuccess) {
  //       print("abc $onSuccess");

  //       EasyLoading.show(status: "please waiting");

  //       Future.delayed(
  //         const Duration(milliseconds: 2000),
  //         () {
  //           sl<SharedPreferenceHelper>().removeJWTToken();
  //           sl<SharedPreferenceHelper>().removeLogin();
  //           sl<SharedPreferenceHelper>().removeIdUser();
  //           if (authResponse.typeRegister.toString().toLowerCase() ==
  //               'GOOGLE') {
  //             googleSignIn.disconnect();
  //           }
  //           EasyLoading.dismiss();
  //           IZIAlert.success(message: "Đăng xuất thành công");

  //           Get.offAllNamed(SplashRoutes.LOGIN);
  //         },
  //       );
  //     },
  //     onError: (onError) {
  //       Get.offAllNamed(SplashRoutes.LOGIN);
  //       print("Đăng xuất thất bại $onError");
  //       IZIAlert.error(message: "Đăng xuất thất bại");
  //     },
  //   );
  // }

}
