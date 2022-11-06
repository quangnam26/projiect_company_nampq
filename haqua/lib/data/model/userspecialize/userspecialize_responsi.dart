import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

class UserSpecializeResponse {
  String? id;
  String? idUser;
  List<dynamic>? idSubSpecializes;
  String? helpYou;
  String? suggestedTopic;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserSpecializeResponse({
    this.id,
    this.idUser,
    this.idSubSpecializes,
    this.helpYou,
    this.suggestedTopic,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  UserSpecializeResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    idUser = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
    idSubSpecializes = !IZIValidate.nullOrEmpty(json['idSubSpecializes']) ? json['idSubSpecializes'] as List<dynamic> : null;
    helpYou = !IZIValidate.nullOrEmpty(json['helpYou']) ? json['helpYou'].toString() : null;
    suggestedTopic = !IZIValidate.nullOrEmpty(json['suggestedTopic']) ? json['suggestedTopic'].toString() : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id.toString();
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idSubSpecializes)) data['idSubSpecializes'] = idSubSpecializes;
    data['helpYou'] = helpYou;
    data['suggestedTopic'] = suggestedTopic;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedat'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'UserSpecializeResponse(id: $id, idUser: $idUser, idSubSpecializes: $idSubSpecializes, helpYou: $helpYou, suggestedTopic: $suggestedTopic, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
