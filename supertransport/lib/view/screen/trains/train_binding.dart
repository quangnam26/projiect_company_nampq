

import 'package:get/get.dart';
import 'package:template/view/screen/trains/train_controller.dart';

class TrainBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<TrainController>(() => TrainController());
  }
}