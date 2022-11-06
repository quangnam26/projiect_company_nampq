import 'dart:async';
import 'package:get_it/get_it.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:template/data/model/provider/provider.dart';
import 'package:template/data/model/provider/url_constanst.dart';
import 'package:template/di_container.dart';

import '../data/datasource/remote/dio/dio_client.dart';
import '../data/model/auth/auth_response.dart';
import '../helper/izi_alert.dart';
import '../helper/izi_validate.dart';
import '../sharedpref/shared_preference_helper.dart';

// ignore: avoid_classes_with_only_static_members
class RefreshTokenUtil {
  static final Provider _provider = Provider();
  static final DioClient _dioClient = GetIt.I.get<DioClient>();

  ///
  /// Check expiration token
  ///
  static bool isExpired() {
    final token = sl<SharedPreferenceHelper>().getJwtToken;

    // Nếu token null
    if (IZIValidate.nullOrEmpty(token)) {
      return false;
    }

    // Kiểm tra token hết hạn
    final bool isExpired = Jwt.isExpired(token);

    return isExpired;
  }

  ///
  /// Làm mới access token và refresh token
  ///
  static Future<void> refreshTokens() async {
    if (isExpired()) {
      // set '' cho refresh token
      sl<SharedPreferenceHelper>().setJwtToken('');

      final refreshToken = sl<SharedPreferenceHelper>().refreshToken;

      // refresh dio
      await _dioClient.refreshToken();

      // Làm mới token
      await _provider.auth(
         AuthResponse(),
        endPoint: REFRESHTOKEN,
        requestBody: AuthResponse(refreshToken: refreshToken),
        onSuccess: (account) async {
          account as AuthResponse;

          // set token và refresh token
          sl<SharedPreferenceHelper>()
              .setJwtToken(account.accessToken.toString());
          sl<SharedPreferenceHelper>()
              .setRefreshToken(account.refreshToken.toString());
          print("object");

          // refresh dio
          await _dioClient.refreshToken();
          print("Làm mới token thành công");

          //Set user id
          if (!IZIValidate.nullOrEmpty(account.user)) {
            sl<SharedPreferenceHelper>()
                .setProfile(account.user!.id.toString());
          }
        },
        onError: (onError) {
          // Get.offAllNamed(AuthRoutes.LOGIN);
          IZIAlert.error(
              message: "Thời gian đăng nhập đã hết hạn vui lòng đăng nhập lại");
          print("An error occurred while refreshToken $onError");
        },
      );
    }
  }
}
