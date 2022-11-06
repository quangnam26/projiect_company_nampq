import 'package:get/get.dart';
import 'package:template/view/screen/history_order/detail/detail_history_order_binding.dart';
import 'package:template/view/screen/history_order/detail/detail_history_order_page.dart';
import 'package:template/view/screen/history_order/history_order_binding.dart';
import 'package:template/view/screen/history_order/history_order_page.dart';

import '../../view/screen/reviewer/reviewer_binding.dart';
import '../../view/screen/reviewer/reviewer_page.dart';
// ignore: avoid_classes_with_only_static_members
class HistoryOrderRoutes {
static const String HISTORYORDER = '/historyOrder';
  static const String DETAILHISTORYORDER = '/detail_history_order';
  static const String  REVIEWER = '/reviewer';
  static List<GetPage> list = [
   GetPage(
      name: HISTORYORDER,
      page: () => HistoryOrderPage(),
      binding: HistoryOrderBinding(),
    ),
    GetPage(
      name: DETAILHISTORYORDER,
      page: () => DetailHistoryPage(),
      binding: DetailHistoryOrderBinding(),
    ),
    GetPage(
      name: REVIEWER,
      page: () => ReviewerPage(),
      binding: ReviewerBinding(),
    ),
    GetPage(
      name: DETAILHISTORYORDER,
      page: () => DetailHistoryPage(),
      binding: DetailHistoryOrderBinding(),
    ),
  ];
}