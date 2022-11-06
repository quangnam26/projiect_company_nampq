import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_controller.dart';

class NotificationBingding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
