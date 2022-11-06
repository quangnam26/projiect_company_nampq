import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

class NotificationResponse {
  String? id;
  String? sendingRange;
  List<String>? idUsers;
  String? typeNotification;
  String? idEntity;
  String? title;
  String? thumbNail;
  String? summary;
  String? content;
  List<String>? readId;
  bool? isRead = false;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? islected;
  bool? isSelectedRead;

  NotificationResponse({
    this.sendingRange,
    this.idUsers,
    this.typeNotification,
    this.idEntity,
    this.title,
    this.thumbNail,
    this.summary,
    this.content,
    this.readId,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.isRead,
    this.isSelectedRead = false,
  });

  ///
  /// From JSON
  ///

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    sendingRange = !IZIValidate.nullOrEmpty(json['sendingRange']) ? json['sendingRange'].toString() : null;
    idUsers = !IZIValidate.nullOrEmpty(json['idUsers']) ? (json['idUsers'] as List<dynamic>).map((e) => e.toString()).toList() : null;
    typeNotification = !IZIValidate.nullOrEmpty(json['typeNotification']) ? json['typeNotification'].toString() : null;
    idEntity = !IZIValidate.nullOrEmpty(json['idEntity']) ? json['idEntity'].toString() : null;
    title = !IZIValidate.nullOrEmpty(json['title']) ? json['title'].toString() : null;
    thumbNail = !IZIValidate.nullOrEmpty(json['thumbnail']) ? json['thumbnail'].toString() : null;
    summary = !IZIValidate.nullOrEmpty(json['summary']) ? json['summary'].toString() : null;
    thumbNail = !IZIValidate.nullOrEmpty(json['thumbnail']) ? json['thumbnail'].toString() : null;
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    readId = !IZIValidate.nullOrEmpty(json['reads']) ? (json['reads'] as List<dynamic>).map((e) => e.toString()).toList() : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id.toString();
    if (!IZIValidate.nullOrEmpty(sendingRange)) data['percent'] = sendingRange;
    if (!IZIValidate.nullOrEmpty(idUsers)) data['idUsers'] = idUsers;
    if (!IZIValidate.nullOrEmpty(typeNotification)) data['typeNotification'] = typeNotification.toString();
    if (!IZIValidate.nullOrEmpty(idEntity)) data['idEntity'] = idEntity.toString();
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title.toString();
    if (!IZIValidate.nullOrEmpty(thumbNail)) data['thumbnail'] = thumbNail.toString();
    if (!IZIValidate.nullOrEmpty(summary)) data['summary'] = summary.toString();
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content.toString();
    if (!IZIValidate.nullOrEmpty(readId)) data['reads'] = readId;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() => 'NotificationResponse(sendingRange: $sendingRange, idCustommers: $idUsers,typeNotification:$typeNotification,idEntity:$idEntity,title:$title,thumbnail:$thumbNail,summary:$summary,content:$content,reads:$readId,createdAt:$createdAt,updateDat:$updatedAt)';
}
