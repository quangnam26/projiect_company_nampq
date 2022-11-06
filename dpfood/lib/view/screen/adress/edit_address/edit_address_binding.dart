

import 'package:get/get.dart';
import 'package:template/view/screen/adress/edit_address/edit_address_controller.dart';

class EditAddressBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EditAddressController>(() => EditAddressController());
  }
}