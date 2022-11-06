// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';

import 'package:template/view/screen/searchresults/search_results_bingding.dart';
import 'package:template/view/screen/searchresults/search_results_page.dart';

import '../../view/screen/favoriteproducts/favorite_products_bingding.dart';
import '../../view/screen/favoriteproducts/favorite_products_page.dart';
import '../../view/screen/searchresults/searchfilter/search_filter_bingding.dart';
import '../../view/screen/searchresults/searchfilter/search_filter_page.dart';

// ignore: avoid_classes_with_only_static_members
class SearchResultsRoutes {
  static const String SEARCH_RESULTS = '/search_results';
  static const String NO_SEARCH_RESULTS = '/no_search_results';
  static const String SEARCH_FILTER = '/search_filter';
  static const String FAVORITE_PRODUCTS = '/favorite_products';
  static const String PRODUCTS_PRORTFOLIOS = '/products_prortfolio';
//search results
  static List<GetPage> list = [
    GetPage(
      name: SEARCH_RESULTS,
      page: () => SearchResultsPage(),
      binding: SearchResultsBingding(),
    ),
// no search results
    // GetPage(
    //   name: NO_SEARCH_RESULTS,
    //   page: () => NoSearchResultsPage(),
    //   binding: NoSearchResultsBingding(),
    // ),

//search_filter
    GetPage(
      name: SEARCH_FILTER,
      page: () => SearchFilterPage(),
      binding: SearchFilterBinhgding(),
    ),
    //favorite_products
    GetPage(
      name: FAVORITE_PRODUCTS,
      page: () => FavoriteProductsPage(),
      binding: FavoriteProductsBingding(),
    )
    // , GetPage(
    //   name: PRODUCTS_PRORTFOLIOS,
    //   page: () => ProductPortfolioPage(),
    //   binding:  ProductPrortfolioBingding(),
    // ),
  ];
}
