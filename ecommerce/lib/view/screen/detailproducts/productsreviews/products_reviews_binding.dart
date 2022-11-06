import 'package:get/get.dart';
import 'package:template/view/screen/detailproducts/productsreviews/products_reviews_controller.dart';

class ProductsReviewsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductsReviewsController>(()=> ProductsReviewsController());
  }
}