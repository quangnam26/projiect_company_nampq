import 'package:get/get.dart';

import '../../view/screen/rating_store.dart/rating_page.dart';
import '../../view/screen/rating_store.dart/rating_store_binding.dart';
import '../../view/screen/search/search_binding.dart';
import '../../view/screen/search/search_page.dart';
import '../../view/screen/store/store_binding.dart';
import '../../view/screen/store/store_page.dart';




// ignore: avoid_classes_with_only_static_members
class HomeRoutes {
  static const String SEARCH = '/search';
  static const String STORE = '/store';
  static const String RATING_STORE = '/rating_store';


  static List<GetPage> list = [
    GetPage(
      name: SEARCH,
      page: () => SearchPage(),
      binding: SearchBinding(),
    ),

    GetPage(
      name: STORE,
      page: () => StorePage(),
      binding: StoreBinding(),
    ),
    
    GetPage(
      name: RATING_STORE,
      page: () => RatingStorePage(),
      binding: RatingStoreBinding(),
    ),
    
  ];
}
