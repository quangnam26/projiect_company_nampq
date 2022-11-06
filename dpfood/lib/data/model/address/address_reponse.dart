// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class AddressResponse {
  String? id;
  String? idUser;
  String? note;
  String? name;
  String? title;
  int? type;
  AddressResponse({
    this.id,
    this.idUser,
    this.note,
    this.name,
    this.type,
    this.title,
  });
  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    type = IZIValidate.nullOrEmpty(json['type']) ? null : IZINumber.parseInt(json['type']);
    idUser = IZIValidate.nullOrEmpty(json['idUser']) ? null : json['idUser'].toString();
    note = IZIValidate.nullOrEmpty(json['note']) ? null : json['note'].toString();
    name = IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
    title = IZIValidate.nullOrEmpty(json['title']) ? null : json['title'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(note)) data['note'] = note;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    return data;
  }
}
