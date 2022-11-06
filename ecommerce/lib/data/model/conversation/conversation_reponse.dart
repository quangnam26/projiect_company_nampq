// ignore_for_file: always_declare_return_types

import 'package:template/helper/izi_number.dart';

import '../../../helper/izi_validate.dart';

class ConversationResponse {
  String? id;
  List<String>? user;
  String? name;
  String? lastMessage;
  int? lastTime;
  String? isRead;
  String? createdAt;
  String? updatedAt;

  ConversationResponse(
      {this.id,
      this.name,
      this.lastMessage,
      this.lastTime,
      this.isRead,
      this.createdAt,
      this.updatedAt});

  ConversationResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    name = (json['name'] == null) ? null : json['name'].toString();
    lastMessage =
        (json['lastMessage'] == null) ? null : json['lastMessage'].toString();
    user = !IZIValidate.nullOrEmpty(json['user'])
        ? (json['user'] as List<dynamic>).map((e) => e.toString()).toList()
        : null;
    lastTime = IZIValidate.nullOrEmpty(json['lastTime'])
        ? null
        : IZINumber.parseInt(json['lastTime']);
    isRead = (json['isRead'] == null) ? null : json['isRead'].toString();
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
    if (!IZIValidate.nullOrEmpty(user)) data['user'] = user;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(lastMessage)) {
      data['lastMessage'] = lastMessage;
    }
    if (!IZIValidate.nullOrEmpty(lastTime)) data['lastTime'] = lastTime;
    if (!IZIValidate.nullOrEmpty(isRead)) data['isRead'] = isRead;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    return data;
  }


  
}
