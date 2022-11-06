// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/helper/izi_validate.dart';

class NotificationResponse {
  String? id;
  String? sendingRange;
  List<String>? idUsers;
  String? typeNotification;
  String? idEntity;
  String? title;
  String? thumbnail;
  String? summary;
  String? content;
  List<String>? reads;
  String? createdAt;
  String? updatedAt;
  NotificationResponse({
    this.id,
    this.sendingRange,
    this.idUsers,
    this.typeNotification,
    this.idEntity,
    this.title,
    this.thumbnail,
    this.summary,
    this.content,
    this.reads,
    this.createdAt,
    this.updatedAt,
  });
  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    sendingRange = IZIValidate.nullOrEmpty(json['sendingRange'])
        ? null
        : json['sendingRange'].toString();
    idUsers = IZIValidate.nullOrEmpty(json['idUser'])
        ? null
        : (json['idUser'] as List<dynamic>).map((e) => e.toString()).toList();
    typeNotification = IZIValidate.nullOrEmpty(json['typeNotification'])
        ? null
        : json['typeNotification'].toString();
    idEntity = IZIValidate.nullOrEmpty(json['idEntity'])
        ? null
        : json['idEntity'].toString();
    title = IZIValidate.nullOrEmpty(json['title'])
        ? null
        : json['title'].toString();
    thumbnail = IZIValidate.nullOrEmpty(json['thumbnail'])
        ? null
        : json['thumbnail'].toString();
    summary = IZIValidate.nullOrEmpty(json['summary'])
        ? null
        : json['summary'].toString();
    content = IZIValidate.nullOrEmpty(json['content'])
        ? null
        : json['content'].toString();
    reads = IZIValidate.nullOrEmpty(json['reads'])
        ? null
        : (json['reads'] as List<dynamic>).map((e) => e.toString()).toList();
    createdAt = IZIValidate.nullOrEmpty(json['createdAt'])
        ? null
        : json['createdAt'].toString();
    updatedAt = IZIValidate.nullOrEmpty(json['updatedAt'])
        ? null
        : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(sendingRange))
      data['sendingRange'] = sendingRange;
    if (!IZIValidate.nullOrEmpty(idUsers)) data['idUsers'] = idUsers;
    if (!IZIValidate.nullOrEmpty(typeNotification))
      data['typeNotification'] = typeNotification;
    if (!IZIValidate.nullOrEmpty(idEntity)) data['idEntity'] = idEntity;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(summary)) data['summary'] = summary;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(reads)) data['reads'] = reads;
    return data;
  }
}
