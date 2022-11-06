import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/shoppingguide/shopping_guide_controller.dart';

class ShoppingGuideBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShoppingGuideController>(()=> ShoppingGuideController());
  }
}