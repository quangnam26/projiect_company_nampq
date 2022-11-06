
import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_controller.dart';

class NoticationBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  
    
  }
}