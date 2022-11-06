
import 'package:get/get.dart';
import 'package:template/view/screen/notification/noticedetails/notice_details_controller.dart';

class NoticeDetailsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NoticeDetailsController>(() => NoticeDetailsController());
  
    
  }
}