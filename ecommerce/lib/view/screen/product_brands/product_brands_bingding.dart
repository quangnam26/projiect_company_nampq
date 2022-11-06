
import 'package:get/get.dart';
import 'package:template/view/screen/product_brands/product_brands_controller.dart';

class ProductBrandsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductBrandsController>(() => ProductBrandsController());     
  }
}