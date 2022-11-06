import 'package:get/get.dart';
import 'package:template/view/screen/accounts/personalinformation/inputpersonalinformation/input_personal_information_controller.dart';

class InputPersonalInformationBingDing extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<InputPersonalInformationController>(()=> InputPersonalInformationController());
  }
}