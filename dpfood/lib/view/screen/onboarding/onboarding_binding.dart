

import 'package:get/get.dart';
import 'package:template/view/screen/onboarding/onboarding_controller.dart';

class OnboardingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}