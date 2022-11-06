
import 'package:get/get.dart';
import 'package:template/view/screen/searchresults/searchfilter/search_filter_controller.dart';

class SearchFilterBinhgding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchFilterController>(SearchFilterController());
  }
}