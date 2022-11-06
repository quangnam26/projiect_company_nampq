import 'package:get/get.dart';
import 'package:template/view/screen/notification/noticedetails/notice_details_bingding.dart';
import 'package:template/view/screen/notification/noticedetails/notice_details_page.dart';
import 'package:template/view/screen/notification/notification_page.dart';

import '../../view/screen/notification/notification_bingding.dart';

// ignore: avoid_classes_with_only_static_members
class NotificationRoutes {
  static const String NOTIFICATION = '/notification';
  static const String NOTICE_DETAILS = '/notice_details';

  static List<GetPage> list = [
    GetPage(
      name: NOTIFICATION,
      page: () => NotificationPage(),
      binding: NoticationBingding(),
    ),
    GetPage(
      name: NOTICE_DETAILS,
      page: () => NoticeDetailsPage(),
      binding: NoticeDetailsBingding  (),
    ),
  ];
}
