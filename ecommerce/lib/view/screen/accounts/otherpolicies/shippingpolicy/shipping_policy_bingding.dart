import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/shippingpolicy/shipping_policy_controller.dart';

class ShippingPolicyBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShippingPolicyController>(()=> ShippingPolicyController());
  }
}