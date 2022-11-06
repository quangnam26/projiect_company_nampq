import 'package:get/get.dart';
import 'package:template/view/screen/notification/notification_binding.dart';
import 'package:template/view/screen/notification/notification_page.dart';

// ignore: avoid_classes_with_only_static_members
class NotificationRoutes {
  static const String NOTIFY = '/notifi';

  static List<GetPage> list = [
    GetPage(
        name: NOTIFY,
        
        page: () => NotificationPage(),
        binding: NotificationBinding()),
  ];
}
