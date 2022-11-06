

import 'package:get/get.dart';
import 'package:template/view/screen/adress/address_controller.dart';

class AddressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddressController>(() => AddressController());
  }
}