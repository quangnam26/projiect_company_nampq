import 'package:get/get.dart';
import 'package:template/view/screen/detailproducts/detail_products_controller.dart';

class DetailProductsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailProductsController>(() => DetailProductsController());
  
    
  }
}