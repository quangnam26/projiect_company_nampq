import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/termsandpolicies/terms_and_policies_controller.dart';

class TermsAndPoliciesBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TermsAndPoliciesController>(()=> TermsAndPoliciesController());
  }
}