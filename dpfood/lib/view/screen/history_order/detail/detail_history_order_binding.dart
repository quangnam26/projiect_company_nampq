import 'package:get/get.dart';
import 'package:template/view/screen/history_order/detail/detail_history_order_controller.dart';

class DetailHistoryOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<DetailHistoryOrderController>(DetailHistoryOrderController());
  }
}