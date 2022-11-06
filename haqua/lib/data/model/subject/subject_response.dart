import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class SubjectResponse {
  String? id;
  String? name;
  int? postion;
  DateTime? createdAt;
  DateTime? updatedAt;
  SubjectResponse(
      {this.id, this.name, this.postion, this.createdAt, this.updatedAt});

  ///
  /// From JSON
  ///
  SubjectResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    name =
        !IZIValidate.nullOrEmpty(json['name']) ? json['name'].toString() : null;
    postion = !IZIValidate.nullOrEmpty(json['postion'])
        ? IZINumber.parseInt(json['postion'].toString())
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
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(postion)) data['postion'] = postion;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedat'] = updatedAt;

    return data;
  }

  @override
  String toString() {
    return 'Subject(id: $id, name: $name, postion: $postion,createdAt:$createdAt, updatedAt:$updatedAt)';
  }
}
