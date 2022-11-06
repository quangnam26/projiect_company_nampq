import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/provider/provider.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:get/get.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

// ignore: deprecated_member_use
class SplashController extends GetxController
    // ignore: deprecated_member_use
    with SingleGetTickerProviderMixin {
  // khai báo API
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  final Provider provider = Provider();
//khai báo biến
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
        final splash = sl<SharedPreferenceHelper>().getSplash;
        final remember = sl<SharedPreferenceHelper>().getRemember;
        final login = sl<SharedPreferenceHelper>().getLogin;

        /// if splash is [true]
        if (splash) {
          Get.offAndToNamed(SplashRoutes.HOME);

          // If user have remember the password and  logged successfully.
          if (remember && login) {
            // Remember password and logged successfully.
            Get.offAndToNamed(SplashRoutes.HOME);
          } else {
            Get.offAndToNamed(SplashRoutes.HOME);
          }
        } else {
          Get.offAndToNamed(SplashRoutes.INTRODUCTION);
        }
      },
    );
  }

  ///
  ///Refresh shared preferences.
  ///
  void refreshSharedPreference() {
    sl<SharedPreferenceHelper>().setRemember(remember: false);
    sl<SharedPreferenceHelper>().setJwtToken('');
    sl<SharedPreferenceHelper>().setProfile('');
    sl<SharedPreferenceHelper>().setRefreshToken('');
  }

}
