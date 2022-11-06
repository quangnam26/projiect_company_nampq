import 'package:template/data/model/notification/notification_response.dart';
import 'package:template/helper/izi_validate.dart';

class NotificationRequest extends NotificationResponse {
  String? idNotification;
  String? idUser;
  List<String>? idNotifications;
  NotificationRequest({
    this.idNotification,
    this.idUser,
  });

  @override
  NotificationRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idNotification = !IZIValidate.nullOrEmpty(json['idNotification']) ? json['idNotification'].toString() : null;
    idUser = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
  }

  ///
  ///toJson
  ///
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idNotification)) data['idNotification'] = idNotification;
    if (!IZIValidate.nullOrEmpty(idNotifications)) data['idNotifications'] = idNotifications;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    return data;
  }
}
