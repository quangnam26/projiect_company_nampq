import 'package:get/get.dart';
import 'package:template/view/screen/account_user/briefcase/briefcase_controller.dart';

class BriefCaseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BriefCaseController>(() => BriefCaseController());
  }
}
