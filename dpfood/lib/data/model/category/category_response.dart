// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
part 'category_response.g.dart';
@HiveType(typeId: 8)
class CategoryResponse {
  @HiveField(0)
  String? id;
  @HiveField(1)
  bool? isShow;
  @HiveField(2)
  int? position;
  @HiveField(3)
  String? thumbnail;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? color;
  @HiveField(6)
  String? createdAt;
  @HiveField(7)
  String? updatedAt;
  CategoryResponse({
    this.id,
    this.isShow,
    this.position,
    this.thumbnail,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    isShow = (json['isShow'] == null) ? null : json['isShow'] as bool;
    position = (json['position'] == null) ? null : IZINumber.parseInt(json['position']);
    thumbnail = (json['thumbnail'] == null) ? null : json['thumbnail'].toString();
    name = (json['name'] == null) ? null : json['name'].toString();
    color = (json['color'] == null) ? null : json['color'].toString();
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(color)) data['color'] = color;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString(){
    return name.toString();
  }

}
