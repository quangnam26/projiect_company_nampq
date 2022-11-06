import 'package:get/get.dart';
import 'package:template/view/screen/accounts/personalInformation/personal_Information_controller.dart';


class PersonalInformationBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PersonalInformationController>(()=> PersonalInformationController());
  }
}