// ignore: file_names
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20warrantypolicy/%20warranty_policy_controller.dart';

class WarrantyPoliciesBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<WarrantyPoliciesController>(()=> WarrantyPoliciesController());
  }
}