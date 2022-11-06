
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/purchasepolicy/purchase_policy_controlller.dart';

class PurchasePolicyBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PurchasePolicyController>(()=> PurchasePolicyController());
  }
}