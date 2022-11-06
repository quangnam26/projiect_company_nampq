// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/data/model/notification/notification_reponse.dart';

class NotificationRequest extends NotificationResponse {
  NotificationRequest();
  NotificationRequest.fromJson(Map<String, dynamic> json)
      : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
