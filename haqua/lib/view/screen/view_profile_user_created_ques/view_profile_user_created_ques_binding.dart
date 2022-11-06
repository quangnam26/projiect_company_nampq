import 'package:get/get.dart';
import 'package:template/view/screen/view_profile_user_created_ques/view_profile_user_created_ques_controller.dart';

class ViewProfileUserCreatedQuesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewProfileUserCreatedQuesController>(() => ViewProfileUserCreatedQuesController());
  }
}
