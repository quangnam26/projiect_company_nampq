


import '../../../helper/izi_validate.dart';

class NotificationResponse {
  String? id;
  bool? isRead = false;
  String? sendingRange;
  List<String>? idUser;
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
    this.idUser,
    this.typeNotification,
    this.idEntity,
    this.title,
    this.thumbnail,
    this.summary,
    this.content,
    this.reads,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    sendingRange =
        (json['sendingRange'] == null) ? null : json['sendingRange'].toString();

    idUser = !IZIValidate.nullOrEmpty(json['idUsers'])
        ? (json['idUsers'] as List<dynamic>).map((e) => e.toString()).toList()
        : null;
    reads = !IZIValidate.nullOrEmpty(json['reads'])
        ? (json['reads'] as List<dynamic>).map((e) => e.toString()).toList()
        : [];

    typeNotification = (json['typeNotification'] == null)
        ? null
        : json['typeNotification'].toString();
    idEntity = (json['idEntity'] == null) ? null : json['idEntity'].toString();
    title = (json['title'] == null) ? null : json['title'].toString();
    thumbnail =
        (json['thumbnail'] == null) ? null : json['thumbnail'].toString();
    print("thumbnail ${json['thumbnail'].toString()}");
    summary = (json['summary'] == null) ? null : json['summary'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt =
        (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(sendingRange)) {
      data['sendingRange'] = sendingRange;
    }
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(typeNotification)) {
      data['typeNotification'] = typeNotification;
    }
    if (!IZIValidate.nullOrEmpty(idEntity)) data['idEntity'] = idEntity;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(summary)) data['summary'] = summary;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(reads)) data['reads'] = reads;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
