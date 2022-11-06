
// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';
import 'package:template/view/screen/category/category_bingding.dart';
import 'package:template/view/screen/category/category_page.dart';

import '../../view/screen/product_brands/product_brands_bingding.dart';
import '../../view/screen/product_brands/product_brands_page.dart';

// ignore: avoid_classes_with_only_static_members
class CategoryRoutes {
  static const String CATEGORY = '/category';
    static const String BRANDS = '/brands';



  static List<GetPage> list = [
    GetPage(
      name: CATEGORY,
      page: () => CategoryPage(),
      binding: CategoryBingding(),
    ),
        GetPage(
      name: BRANDS,
      page: () => ProductBrandsPage(),
      binding: ProductBrandsBingding(),
    ),

  ];
}
