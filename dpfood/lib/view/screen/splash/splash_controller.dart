import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/provider/provider.dart';
import 'package:template/data/model/provider/url_constanst.dart';
import 'package:template/di_container.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:get/get.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/geocoding.dart';
import '../../../helper/izi_validate.dart';

// ignore: deprecated_member_use
class SplashController extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController? _animationController;
  final DioClient? dioClient = GetIt.I.get<DioClient>();
  final Geocoding geocoding = GetIt.I.get<Geocoding>();
  final Provider provider = Provider();
  @override
  void onInit() {
    geocoding.requiredPermission();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationController!.forward().whenComplete(
      () async {
        // Get.offAndToNamed(SplashRoutes.ON_BOARDING);
        final splash = sl<SharedPreferenceHelper>().getSplash;
        final remember = sl<SharedPreferenceHelper>().getRemember;
        if (splash) {
          if (remember) {
            // onRefreshToken();
            Get.offAndToNamed(SplashRoutes.HOME);
          } else {
            Get.offAndToNamed(AuthRoutes.LOGIN);
          }
        } else {
          Get.offAndToNamed(SplashRoutes.ON_BOARDING);
        }
      },
    );
    super.onInit();
  }

  ///
  /// refresh token
  ///
  Future<void> onRefreshToken() async{
    final token = sl<SharedPreferenceHelper>().getJwtToken;
    final refreshToken = sl<SharedPreferenceHelper>().refreshToken;
    
    // Nếu token or refresh token null thì => login
    if (IZIValidate.nullOrEmpty(token) || IZIValidate.nullOrEmpty(refreshToken)) {
      Get.offAndToNamed(AuthRoutes.LOGIN);
      return;
    }

    final isExpired = Jwt.isExpired(token);

    // Check hết hạn
    if (isExpired) {
      sl<SharedPreferenceHelper>().setJwtToken('');
      await dioClient!.refreshToken();
      refreshTokens(
        refreshToken: refreshToken,
      );
      return;
    }

    Get.offAndToNamed(SplashRoutes.HOME);
  }

  ///
  /// Làm mới access token và refresh token
  ///
  void refreshTokens({required String refreshToken,Function? onCallback}) {
    provider.auth(
      AuthResponse(),
      endPoint: REFRESHTOKEN,
      requestBody: AuthResponse(refreshToken: refreshToken),
      onSuccess: (account) async {
        sl<SharedPreferenceHelper>().setJwtToken(account.accessToken.toString());
        sl<SharedPreferenceHelper>().setRefreshToken(account.refreshToken.toString());
        await dioClient!.refreshToken();
        if (!IZIValidate.nullOrEmpty(account.user)) {
          sl<SharedPreferenceHelper>().setProfile(account.user!.id.toString());
        }
        Get.offAndToNamed(SplashRoutes.HOME);
      },
      onError: (onError) {
        print("An error occurred while refreshToken $onError");
        Get.offAndToNamed(AuthRoutes.LOGIN);
      },
    );
  }
}
