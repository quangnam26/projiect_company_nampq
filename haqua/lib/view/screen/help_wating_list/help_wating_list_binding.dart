


import 'package:get/get.dart';
import 'package:template/view/screen/help_wating_list/help_wating_list_controller.dart';

class HelpWatingListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HelpWatingListController>(() => HelpWatingListController());
  }
}