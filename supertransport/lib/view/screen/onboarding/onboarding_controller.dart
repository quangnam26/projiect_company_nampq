// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import '../../../di_container.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/images_path.dart';

class OnboardingController extends GetxController {
  final List<Map<String, String>> splashs = [
    {
      'title': 'Yêu cầu chuyến xe',
      'description': 'Mạng lưới giao hàng rộng lớn. Giúp bạn tìm\nđược chuyến đi thoải mái, an toàn và rẻ.',
      'image': ImagesPath.splash1,
    },
    {
      'title': 'Yêu cầu chở đồ',
      'description': 'Yêu cầu chở đồ được tài xế cùng tuyến đón\ngần nhất, nhanh nhất và rẻ',
      'image': ImagesPath.splash2,
    },
    {
      'title': 'Thông tin chuyến xe',
      'description': 'Tất cả các chuyến rành mạch, an toàn\nvà tiện lợi',
      'image': ImagesPath.splash3,
    }
  ];
  final PageController pageController = PageController();
  int currentIndex = 0;
  @override
  void onInit() {
    super.onInit();
  }

  ///
  ///  Changed page index
  ///
  void onPageChanged(int index) {
    currentIndex = index;
    update();
  }

  ///
  /// on Next
  ///
  void onNext() {
    if (currentIndex == splashs.length - 1) {
      // Get.toNamed(SplashRoutes.HOME);
      sl<SharedPreferenceHelper>().setSplash(
        status: true,
      );
      Get.toNamed(AuthRoutes.LOGIN);
    } else {
      pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  ///
  /// on Skip
  ///
  void onSkip() {
    pageController.animateToPage(
      splashs.length - 1,
      duration: const Duration(milliseconds: 1200),
      curve: Curves.easeOut,
    );
  }
}
