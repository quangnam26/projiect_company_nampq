

import 'package:get/get.dart';
import 'package:template/view/screen/terms_and_policy/terms_and_policy_controller.dart';

class TermsAndPolicyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TermsAndPolicyController>(() => TermsAndPolicyController());
  }
}