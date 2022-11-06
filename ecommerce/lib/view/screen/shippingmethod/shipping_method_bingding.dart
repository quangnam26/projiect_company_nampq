
import 'package:get/get.dart';
import 'package:template/view/screen/shippingmethod/shipping_method_controller.dart';

class ShipperMethodBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShipperMethodController>(()=> ShipperMethodController());
  }
}