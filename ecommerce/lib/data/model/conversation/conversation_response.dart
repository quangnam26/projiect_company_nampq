// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ConversationResponse {
  String? id;
  String? isRead;
  int? lastTime;
  String? lastmessage;
  String? name;
  List<String>? users;
  String? createdAt;
  String? updatedAt;
  ConversationResponse({
    this.id,
    this.isRead,
    this.lastTime,
    this.lastmessage,
    this.name,
    this.users,
    this.createdAt,
    this.updatedAt,
  });

  ConversationResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    isRead = (json['isRead'] == null) ? null : json['isRead'] as String;
    lastTime = (json['lastTime'] == null) ? null : IZINumber.parseInt(['lastTime']);
    lastmessage = (json['lastmessage'] == null) ? null : json['lastmessage'].toString();
    name = (json['name'] == null) ? null : json['name'].toString();
    users = (json['users'] == null) ? null :  (json['users'] as List<dynamic>).convertToListString();  //.map((e) => e.toString()).toList();
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(isRead)) data['isRead'] = isRead;
    if (!IZIValidate.nullOrEmpty(lastTime)) data['lastTime'] = lastTime;
    if (!IZIValidate.nullOrEmpty(lastmessage)) data['lastmessage'] = lastmessage;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(users)) data['users'] = users;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}

extension ConvertToListString<T> on Iterable<T>{
  List<String> convertToListString(){
    try{
    return map((e) => e.toString()).toList();
    }catch (e) {
      return [];
    }
  }
}