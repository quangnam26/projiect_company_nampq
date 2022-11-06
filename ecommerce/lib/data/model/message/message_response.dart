// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:template/data/model/conversation/conversation_response.dart';
import 'package:template/helper/izi_validate.dart';

class MessageResponse {
  String? id;
  bool? isDeleted;
  String? content;
  String? type;
  String? user;
  List<String>? images;
  ConversationResponse? conversation;
  String? createdAt;
  String? updatedAt;
  MessageResponse({
    this.id,
    this.isDeleted,
    this.content,
    this.type,
    this.user,
    this.conversation,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  MessageResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    isDeleted = (json['isDeleted'] == null) ? null : json['isDeleted'] as bool;
    content = (json['content'] == null) ? null : json['content'] as String;
    type = (json['type'] == null) ? null : json['type'].toString();
    user = (json['user'] == null) ? null : json['user'].toString();
    images = (json['images'] == null) ? null : (json['images'] as List<dynamic>).convertToListString();
    conversation = (json['conversation'] == null || json['conversation'].toString().length >= 24) ? ConversationResponse(id: json['conversation'].toString()) : ConversationResponse.fromJson(json['conversation'] as Map<String, String>); //.map((e) => e.toString()).toList();
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(isDeleted)) data['isDeleted'] = isDeleted;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    if (!IZIValidate.nullOrEmpty(user)) data['user'] = user;
    if (!IZIValidate.nullOrEmpty(images)) data['images'] = images;
    if (!IZIValidate.nullOrEmpty(conversation)) data['conversation'] = conversation;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) {
  //     return true;
  //   }
  //   if (other.runtimeType != runtimeType) {
  //     return false;
  //   }
  //   return other is MessageResponse && other.id == id && other.name == offset ;
  // }
}
