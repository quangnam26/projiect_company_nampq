import 'package:get/get.dart';
import 'package:template/view/screen/order/detail_order/detail_order_binding.dart';
import 'package:template/view/screen/order/detail_order/detail_order_page.dart';
import 'package:template/view/screen/order/order_binding.dart';
import 'package:template/view/screen/order/order_page.dart';
import 'package:template/view/screen/order/reviewer_order/reviewer_order_binding.dart';
import 'package:template/view/screen/order/reviewer_order/reviewer_order_page.dart';

// ignore: avoid_classes_with_only_static_members
class OrderRoutes {
  static const String ORDER = '/order';
  static const String DETAIL_ORDER = '/detail_order';
  static const String REVIEWER_ORDER = '/reviewer_order';

  static List<GetPage> list = [
    GetPage(
      name: ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: DETAIL_ORDER,
      page: () => DetailOrderPage(),
      binding: DetailOrderBingding(),
    ),
    GetPage(
      name: REVIEWER_ORDER,
      page: () => ReviewerOrderPage(),
      binding: ReviewerOrderBinding(),
    ),
  ];
}
