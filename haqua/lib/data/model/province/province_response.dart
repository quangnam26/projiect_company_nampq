import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

class ProvinceResponse {
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProvinceResponse({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  ProvinceResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    name = !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()).toLocal() : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()).toLocal() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;

    return data;
  }

  @override
  String toString() {
    return name.toString();
  }
}
