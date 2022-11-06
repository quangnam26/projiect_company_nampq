import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20exchangepolicy/%20exchange_policy_controller.dart';

class ExchangePolicyBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ExchangePolicyController>(()=> ExchangePolicyController());
  }
}