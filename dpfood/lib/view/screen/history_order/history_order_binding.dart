import 'package:get/get.dart';
import 'package:template/view/screen/history_order/history_order_controller.dart';

class HistoryOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<HistoryOrderController>(HistoryOrderController());
  }
}
