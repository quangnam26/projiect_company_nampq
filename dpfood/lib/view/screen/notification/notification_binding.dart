
import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put<NotificationController>(NotificationController());
  }
}