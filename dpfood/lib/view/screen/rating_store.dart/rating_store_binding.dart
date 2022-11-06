

import 'package:get/get.dart';
import 'package:template/view/screen/rating_store.dart/rating_controller.dart';

class RatingStoreBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RatingStoreController>(() => RatingStoreController());
  }
}