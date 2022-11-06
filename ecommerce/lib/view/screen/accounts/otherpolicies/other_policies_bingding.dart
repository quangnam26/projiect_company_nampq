import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/other_policies_controller.dart';

class OtherPoliciesBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OtherPoliciesController>(()=> OtherPoliciesController());
  }
}