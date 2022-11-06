import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class CategoryResponse {
  String? id;
  String? name;
  String? thumbnail;
  bool? isShow;
  int? position;
  String? idParent;
  String? createdAt;
  String? updatedAt;
  int? quantityPr;

  CategoryResponse(
      {this.id, this.isShow, this.position, this.thumbnail, this.name});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    isShow = (json['isShow'] == null) ? null : json['isShow'] as bool;
    position = (json['position'] == null)
        ? null
        : IZINumber.parseInt(json['position']);
    thumbnail = (json['image'] == null) ? null : json['image'].toString();
    name = (json['name'] == null) ? null : json['name'].toString();
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
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['image'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(idParent)) data['idParent'] = idParent;

    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
