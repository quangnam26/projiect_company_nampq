import 'package:get/get.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_controller.dart';

class AddressDeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddressDeliveryController>(AddressDeliveryController());
  }
}