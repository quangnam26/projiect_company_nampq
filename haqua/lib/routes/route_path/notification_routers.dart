import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_page.dart';
import 'package:template/view/screen/notification/notification_bingding.dart';

class NotificationRouters {
  static const String NOTIFICATION = '/notification';

  static List<GetPage> list = [
    GetPage(
        name: NOTIFICATION,
        page: () => const NotificationPage(),
        binding: NotificationBingding()),
  ];
}
