

import 'package:get/get.dart';
import 'package:template/view/screen/search/search_controller.dart';

class SearchBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchController>(()=> SearchController());
  }
}