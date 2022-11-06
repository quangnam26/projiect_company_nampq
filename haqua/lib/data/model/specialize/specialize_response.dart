import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class SpecializeResponse {
  String? id;
  String? name;
  int? position;
  DateTime? createdAt;
  DateTime? updatedAt;
  SpecializeResponse(
      {this.id, this.name, this.position, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  SpecializeResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    name =
        !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    position = !IZIValidate.nullOrEmpty(json['position'])
        ? IZINumber.parseInt(json['position'].toString())
        : null;

    createdAt = !IZIValidate.nullOrEmpty(json['createdAt'])
        ? IZIDate.parse(json['createdAt'].toString())
        : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt'])
        ? IZIDate.parse(json['updatedAt'].toString())
        : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id.toString();
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name.toString();
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedat'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'ContestsResponse(id: $id, name: $name, postion: $position,createdAt:$createdAt,updatedAt:$updatedAt)';
  }
}
