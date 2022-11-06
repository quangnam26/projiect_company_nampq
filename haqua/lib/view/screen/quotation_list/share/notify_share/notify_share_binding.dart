import 'package:get/get.dart';
import 'package:template/view/screen/quotation_list/share/notify_share/notify_share_controller.dart';

class NotifyShareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifyShareController>(() => NotifyShareController());
  }
}
