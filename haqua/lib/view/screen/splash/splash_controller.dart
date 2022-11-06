import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:template/di_container.dart';
import 'package:get/get.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/routes/route_path/sign_in_or_sign_up_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class SplashController extends GetxController with SingleGetTickerProviderMixin {
  ///
  /// Declare Data.
  late AnimationController? _animationController;

  @override
  void onInit() {
    super.onInit();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController!.forward().whenComplete(
      () async {
        checkInternet();
      },
    );
  }

  ///
  /// Check Internet.
  ///
  Future<void> checkInternet() async {
    ///
    /// Set is Calling is default.
    sl<SharedPreferenceHelper>().setCalling(isCalling: false);

    /// If have't internet then go to [No internet page] else go to [Sign in or sign up page].
    final bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      Get.toNamed(SignInOrSignUpRoutes.SIGN_IN_OR_SIGN_UP);
    } else {
      Get.toNamed(HomeRoutes.NO_INTERNET);
    }
  }
}
