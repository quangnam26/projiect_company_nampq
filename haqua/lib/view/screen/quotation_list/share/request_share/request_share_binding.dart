import 'package:get/get.dart';
import 'package:template/view/screen/quotation_list/share/request_share/request_share_controller.dart';

class RequestShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestShareController>(() => RequestShareController());
  }
}
