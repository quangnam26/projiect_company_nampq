import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/userspecialize_provider.dart';
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../../../routes/route_path/introduction_routers.dart';

class SignUpAndSignInController extends GetxController {
  /// Declare  API.
  final UserSpecializeProvider userSpecializeProvider = GetIt.I.get<UserSpecializeProvider>();

  /// Declare Data.
  final List<Map<String, dynamic>> localeList = [
    {
      'name': 'vietnamese'.tr,
      'locale': const Locale('vi', 'VN'),
    },
    {
      'name': 'english'.tr,
      'locale': const Locale('en', 'US'),
    },
  ];
  RxString locale = ''.obs;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();

    /// Check have logger.
    checkIsLogger();
  }

  @override
  void dispose() {
    locale.close();
    super.dispose();
  }

  ///
  /// Check have logger.
  ///
  void checkIsLogger() {
    /// Check language.
    final String language = sl<SharedPreferenceHelper>().getLanguage;
    if (language == 'vi' || language == 'vi_VN') {
      locale.value = 'vietnamese'.tr;
    } else {
      locale.value = 'english'.tr;
    }

    final isLogin = sl<SharedPreferenceHelper>().getLogin;
    final splash = sl<SharedPreferenceHelper>().getSplash;

    /// If the first logger app.
    if (!IZIValidate.nullOrEmpty(splash) && splash == true) {
      ///
      /// If is logger then check condition below.
      if (!IZIValidate.nullOrEmpty(isLogin) && isLogin == true) {
        Future.delayed(Duration.zero, () async {
          ///
          /// Check User have already registered specialize not yet.
          userSpecializeProvider.paginate(
            page: 1,
            limit: 1,
            filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}",
            onSuccess: (models) {
              ///
              /// If have already registered then go to [Dashboard] else go to areas of expertise.
              if (models.isNotEmpty) {
                isLoading = false;
                Get.offAllNamed(HomeRoutes.DASHBOARD);
              } else {
                Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE);
              }
            },
            onError: (error) {
              print(error);
            },
          );
        });
      } else {
        ///
        /// If not logged then go to [Dashboard page] with guest account.
        Future.delayed(Duration.zero, () {
          isLoading = false;
          Get.offAllNamed(HomeRoutes.DASHBOARD);
        });
      }
    } else {
      isLoading = false;
    }

    /// Just [update] first load [Sign up and Sign in page].
    if (isLoading) {
      update();
    }
  }

  ///
  /// On Change Language.
  ///
  void onChangedLanguage(String val) {
    locale.value = val;

    if (locale.value == 'vietnamese'.tr) {
      sl<SharedPreferenceHelper>().setLanguage('vi');
    } else {
      sl<SharedPreferenceHelper>().setLanguage('en');
    }
    Get.updateLocale(localeList[localeList.indexWhere((element) => element['name'].toString() == locale.value)]['locale'] as Locale);
  }

  ///
  /// Continue to [Introduction page] .
  ///
  void continueIntro() {
    Get.toNamed(IntroductionRoutes.INTRODUCTION);
  }
}
