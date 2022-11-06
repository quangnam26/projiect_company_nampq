import 'package:get/get.dart';
import 'package:template/view/screen/accounts/contact/contact_controller.dart';

class ContactBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(()=> ContactController());
  }
}