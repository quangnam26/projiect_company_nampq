import 'package:get/get.dart';
import 'package:template/view/screen/category/category_controller.dart';

class CategoryBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(() => CategoryController()); 
    
  }
}