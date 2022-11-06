import 'package:flutter/material.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:get/get.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

// ignore: deprecated_member_use
class SplashController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;
  @override
  void onInit() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController!.forward().whenComplete(
      () async {
        final splash = sl<SharedPreferenceHelper>().getSplash;
        final remember = sl<SharedPreferenceHelper>().getRemember;
        if (splash) {
          if (remember) {
            Get.toNamed(SplashRoutes.HOME);
          } else {
            Get.toNamed(AuthRoutes.LOGIN);
          }
        } else {
          Get.toNamed(SplashRoutes.ON_BOARDING);
        }
      },
    );
    super.onInit();
  }


  ///
  /// refresh token
  ///
  void refreshToken() {
    
  }

}
