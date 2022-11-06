import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class GroupProductResponse {
  String? id;
  int? position;
  String? name;
  UserResponse? idUser;
  String? createdAt;
  String? updatedAt;
  GroupProductResponse({
    this.id,
    this.position,
    this.name,
    this.idUser,
    this.createdAt,
    this.updatedAt,
  });
  
  GroupProductResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    position = (json['position'] == null) ? null : IZINumber.parseInt(json['position']);
    name = (json['name'] == null) ? null : json['name'].toString();
    idUser = (json['idUser'] == null) ? null : UserResponse.fromMap(json['idUser'] as Map<String, dynamic>);
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
