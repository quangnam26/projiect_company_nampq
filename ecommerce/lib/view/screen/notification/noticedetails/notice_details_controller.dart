import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/notification/notification_reponse.dart';

import '../../../../provider/notification_provider.dart';

class NoticeDetailsController extends GetxController {
  // khai bao api
  final NotificationProvider notificationProvider =
      GetIt.I.get<NotificationProvider>();
  NotificationResponse notificationResponse = NotificationResponse();



  void getDataNotificationDetail() {
    notificationProvider.find(
      id: Get.arguments as String,
      onSuccess: (model) {
        notificationResponse = model;
        update();
      },
      onError: (onError) {},
    );
  }
}
