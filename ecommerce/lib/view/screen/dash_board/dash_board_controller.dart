import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/accounts/account_page.dart';
import 'package:template/view/screen/cart/cart_page.dart';
import 'package:template/view/screen/huntingvouchers/hunting_vouchers_page.dart';
import 'package:template/view/screen/news/new_controller.dart';
import 'package:template/view/screen/news/news_page.dart';

import '../../../base_widget/izi_dialog.dart';
import '../../../routes/route_path/splash_routes.dart';
import '../home/home_page.dart';

class DashBoardController extends GetxController {
  final List<Map<String, dynamic>> pages = [
    {
      'label': "Home",
      'icon': Icons.home,
      'page': HomePage(),
    },
    {
      'label': "Giỏ hàng",
      'icon': CupertinoIcons.shopping_cart,
      'page': CartPage(),
    },
    {
      'label': "Khuyến Mãi",
      'icon': CupertinoIcons.tag,
      'page': HuntingVoucherPage(),
    },
    {
      'label': "Tin tức",
      'icon': CupertinoIcons.news,
      'page': NewsPage(),
    },
    {
      'label': "Tài khoản",
      'icon': CupertinoIcons.person,
      'page': AccountPage(),
    },
  ];

  DateTime? currentBackPressTime;

  RxInt currentIndex = 0.obs;
  double sizeIcon = 24.0;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments.runtimeType == int) {
        currentIndex.value = Get.arguments as int;
      }
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    currentIndex.close();
    super.onClose();
  }

  ///
  ///Thay đổi page
  ///
  void onChangedPage(int index) {
    currentIndex.value = index;
    // ignore: unused_local_variable
    final newController = Get.find<NewsController>();
    // newController.clearForm();
    update();
  }

  ///
  /// change page add
  ///
  void onTapFloatActionButton() {
    currentIndex.value = FLOAT_ACTION_BUTTON_PAGE;
    update();
  }

  ///
  /// back press
  ///

  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            const Duration(
              seconds: 2,
            )) {
      currentBackPressTime = now;
      print(currentBackPressTime);
      IZIAlert.info(
        message: "Do you want exit the application.",
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  void checkLogin() {
    IZIDialog.showDialog(
        description: "Bạn phải đăng nhập để được mua hàng ",
        lable: 'Đăng nhập LOGIN',
        onConfirm: () {
          EasyLoading.show(status: "please waiting");
          Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              EasyLoading.dismiss();
              Get.offAllNamed(SplashRoutes.LOGIN);
            },
          );
        },
        onCancel: () {
          Get.back();
        });
  }
}
