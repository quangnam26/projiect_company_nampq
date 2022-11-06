// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import '../../../di_container.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/images_path.dart';

class OnboardingController extends GetxController {
  final List<Map<String, dynamic>> splashs = [
    {
      'title': 'GIAO HÀNG NHANH CHÓNG',
      'description': [
        {
          'text': 'HỆ THỐNG SHIPPER ĐƯỢC ',
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
      'title': 'HỆ THỐNG CỬA HÀNG ĐA DẠNG',
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
          'text': 'ĐẢM BẢO PHỤC VỤ KHÁCH HÀNG NHỮNG MÓN ĂN THỨC UỐNG ',
          'highlight': 0,
        },
        {
          'text': 'NGON NHẤT, ĐỘC ĐÁO ',
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
