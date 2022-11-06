import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/home/home_controller.dart';
import '../../../data/model/provider/provider.dart';
import '../../../data/model/user/user_request.dart';
import '../../../di_container.dart';
import '../../../helper/izi_alert.dart';
import '../../../routes/route_path/account_routes.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class AccountController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final Provider provider = Provider();

  List<Map<String, dynamic>> menus = [];
  String idUser = '';
  bool isLoadingUser = true;
  UserRequest? userRequest;
  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getUser();
    menus = [
      {
        'title': 'Thông tin tài khoản',
        'icon': CupertinoIcons.person,
        'onTap': () {
          onToUpdateAccount();
        },
        'color': ColorResources.GREEN,
      },
      {
        'title': 'Danh sách tin đăng tuyển',
        'icon': CupertinoIcons.square_list_fill,
        'onTap': () {
          onToTrain();
        },
        'color': ColorResources.ORANGE,
      },
      {
        'title': 'Điều khoản và chính sách',
        'icon': Icons.policy,
        'onTap': () {
          onToTermAndPolicy();
        },
        'color': ColorResources.PRIMARY_2,
      },
      {
        'title': 'Chia sẻ bạn bè',
        'icon': CupertinoIcons.share_up,
        'onTap': () {
          onShare();
        },
        'color': ColorResources.PRIMARY_1,
      },
      {
        'title': 'Đăng xuất',
        'icon': Icons.logout,
        'onTap': () {
          logout();
        },
        'color': ColorResources.RED,
      },
    ];
  }

  void onToUpdateAccount() {
    Get.toNamed(
      AccountRoutes.UPDATE_ACCOUNT,
    )?.then(
      (value) {
        getUser();
        final homeController = Get.find<HomeController>();
        homeController.getAccount();
      },
    );
  }

  ///
  ///get user
  ///
  void getUser() {
    provider.findOne(
      UserRequest(),
      id: idUser,
      onSuccess: (data) {
        userRequest = data as UserRequest;
        isLoadingUser = false;
        update();
      },
      onError: (onError) {
        print("An error occurred while getting the user $onError");
      },
    );
  }

  void onToTrain() {
    
  }

  void onToTermAndPolicy() {
    Get.toNamed(
      AccountRoutes.TERMS_AND_POLICY,
    );
  }

  void logout() {
    provider.add(
      Object(),
      requestBody: AuthRequest(
        fcmToken: 'Đăng xuất thành công'
      ),
      onSuccess: (data) {
        sl<SharedPreferenceHelper>().setJwtToken('');
        sl<SharedPreferenceHelper>().setProfile('');
        sl<SharedPreferenceHelper>().setRefreshToken('');
        // sl<SharedPreferenceHelper>().setSplash(status: false);
        sl<SharedPreferenceHelper>().setRemember(remember: false);
        Get.offAllNamed(
          AuthRoutes.LOGIN,
        );
        IZIAlert.success(message: "Đăng xuất thành công");
      },
      onError: (onError) {
        print("Đăng xuất thất bại $onError");
        IZIAlert.error(message: "Đăng xuất thất bại");
      },
    );
  }

  Future<void> onShare() async {
    await Share.share(
      Platform.isIOS ? 'https://apps.apple.com/vn/app/clips/id1597116330?l=vi' : "https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=io.izisoft.p23dpfood",
      subject: "Chia sẻ bạn bè và mọi người cùng biết nào !!!",
    );
  }
}
