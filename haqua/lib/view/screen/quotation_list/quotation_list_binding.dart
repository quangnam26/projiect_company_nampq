import 'package:get/get.dart';
import 'package:template/view/screen/quotation_list/quotation_list_controller.dart';

class QuotationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuotationListController>(() => QuotationListController());
  }
}
