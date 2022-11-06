import 'package:get/get.dart';
import 'package:template/view/screen/searchresults/search_results_controller.dart';

class SearchResultsBingding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchResultsController>(SearchResultsController());
  }
}
