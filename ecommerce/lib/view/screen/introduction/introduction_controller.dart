import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../di_container.dart';
import '../../../routes/route_path/splash_routes.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/images_path.dart';

class IntroductionController extends GetxController {
  //List
  final List<Map<String, dynamic>> splashs = [
    {
      'title': 'GIAO HÀNG NHANH CHÓNG',
      'description': [
        {
          'text': 'HỆ THỐNG BÁN HÀNG ĐƯỢC ',
          'highlight': 0,
        },
        {
          'text': 'ĐÀO TẠO ',
          'highlight': 1,
        },
        {
          'text': 'BÀI BẢN, CAM KẾT PHỤC VỤ KHÁCH HÀNG MỘT CÁCH ',
          'highlight': 0,
        },
        {
          'text': 'TỐT NHẤT',
          'highlight': 1,
        },
      ],
      'image': ImagesPath.splash1,
    },
    {
      'title': 'HỆ THỐNG GIAN HÀNG ĐA DẠNG',
      'description': [
        {
          'text': 'VỚI ',
          'highlight': 0,
        },
        {
          'text': 'HÀNG NGÀN CỬA HÀNG ',
          'highlight': 1,
        },
        {
          'text': 'ĐẢM BẢO PHỤC VỤ KHÁCH HÀNG MUA SẮM ',
          'highlight': 0,
        },
        {
          'text': 'HÀNG ĐẸP, CHẤT LƯỢNG, ĐỘC ĐÁO ',
          'highlight': 1,
        },
        {
          'text': 'VÀ ',
          'highlight': 0,
        },
        {
          'text': 'LẠ MẮT NHẤT',
          'highlight': 1,
        },
      ],
      'image': ImagesPath.splash2,
    },
    {
      'title': 'VOUCHER KHUNG',
      'description': [
        {
          'text': 'HÀNG NGÀN ',
          'highlight': 0,
        },
        {
          'text': 'VOUCHER ',
          'highlight': 1,
        },
        {
          'text': 'ĐƯỢC TUNG RA MỖI NGÀY ĐỂ TĂNG THÊM ƯU ĐÃI CHO ',
          'highlight': 0,
        },
        {
          'text': 'KHÁCH HÀNG',
          'highlight': 1,
        },
      ],
      'image': ImagesPath.splash3,
    }
  ];

// khai báo biến
  final PageController pageController = PageController();
  int currentIndex = 0;

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
      Get.offAndToNamed(SplashRoutes.HOME);
    } else {
      pageController.animateToPage(
        currentIndex + 1,
        duration: const Duration(milliseconds: 1000),
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
