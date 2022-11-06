import 'package:get/get.dart';
import 'package:template/view/screen/news/detailednews/detailed_news_bingding.dart';
import 'package:template/view/screen/news/detailednews/detailed_news_page.dart';
import 'package:template/view/screen/news/news_page.dart';

import '../../view/screen/news/new_bingding.dart';

// ignore: avoid_classes_with_only_static_members
class NewsRouters {
  static const String NEWS = '/news';
    static const String DETAILED_NEWS = '/detailed_news';

  static List<GetPage> list = [
    GetPage(
      name: NEWS,
      page: () => NewsPage(),
      binding: NewsBingding(),
    ),
       GetPage(
      name: DETAILED_NEWS,
      page: () => DetailedNewPage(),
      binding: DetailedNewsBingding(),
    )
  ];
}
