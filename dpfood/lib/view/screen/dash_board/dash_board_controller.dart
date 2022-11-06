import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/utils/app_constants.dart';

import '../account/account_page.dart';
import '../home/home_page.dart';

class DashBoardController extends GetxController {
  final List<Map<String, dynamic>> pages = [
    {
      'label': "Trang chủ",
      'icon': Icons.home,
      'page': HomePage(),
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

  ///
  ///Thay đổi page
  ///
  void onChangedPage(int index) {
    currentIndex.value = index;
    update();
  }

  ///
  /// change page add
  ///
  void onTapFloatActionButton(){
    currentIndex.value = FLOAT_ACTION_BUTTON_PAGE;
    update();
  }

  ///
  /// back press
  ///

  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      print(currentBackPressTime);
      IZIAlert.info(message: "Do you want exit the application.");
      return Future.value(false);
    }
    return Future.value(true);
  }
}
