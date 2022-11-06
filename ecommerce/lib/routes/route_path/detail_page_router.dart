import 'package:get/get.dart';
import 'package:template/view/screen/detailproducts/detail_products_bingding.dart';
import 'package:template/view/screen/detailproducts/detail_products_page.dart';
import 'package:template/view/screen/detailproducts/productsreviews/products_reviews_binding.dart';
import 'package:template/view/screen/detailproducts/productsreviews/products_reviews_page.dart';


// ignore: avoid_classes_with_only_static_members
class DetailPageRoutes {
  static const String DETAIL_PAGE = '/detail_page';
   static const String PRODUCTS_REVIEW = '/products_review';

  static List<GetPage> list = [
    GetPage(
      name: DETAIL_PAGE,
      page: () => DetailProductsPage(),
      binding: DetailProductsBingding(),
    ),
      GetPage(
      name: PRODUCTS_REVIEW,
      page: () => ProductsReviewPage(),
      binding: ProductsReviewsBingding(),
    )
  ];
}
