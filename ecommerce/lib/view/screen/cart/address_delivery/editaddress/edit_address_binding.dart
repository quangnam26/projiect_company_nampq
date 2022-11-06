import 'package:get/get.dart';
import 'package:template/view/screen/cart/address_delivery/editaddress/edit_address_controller.dart';

class EditAddressBingDing extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(()=> EditAddressController());
  }
}