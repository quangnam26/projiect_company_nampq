import 'package:get/get.dart';
import 'package:template/view/screen/favoriteproducts/favorite_products_controller.dart';

class FavoriteProductsBingding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavoriteProductsController>(FavoriteProductsController());
  }
}