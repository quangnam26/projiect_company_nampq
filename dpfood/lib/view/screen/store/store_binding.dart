

import 'package:get/get.dart';
import 'package:template/view/screen/store/store_controller.dart';

class StoreBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<StoreController>(() => StoreController());
  }
}