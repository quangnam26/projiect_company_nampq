import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/introduction_routers.dart';
import 'package:template/routes/route_path/sign_in_or_sign_up_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';

import '../../../di_container.dart';

class NoInternetController extends GetxController {
  ///
  /// checkInternet
  ///
  Future<void> checkInternet() async {
    final bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      final splash = sl<SharedPreferenceHelper>().getSplash;
      if (!IZIValidate.nullOrEmpty(splash) && splash == true) {
        Get.toNamed(SignInOrSignUpRoutes.SIGN_IN_OR_SIGN_UP);
      } else {
        Get.toNamed(IntroductionRoutes.INTRODUCTION);
      }
    } else {
      IZIToast().error(
        message: "You are disconnected from the internet.",
        sizeWidthToast: IZIDimensions.iziSize.width * .8,
        colorBG: ColorResources.GREY,
        toastDuration: const Duration(seconds: 3),
      );
    }
  }
}
