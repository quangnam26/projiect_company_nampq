import 'package:template/helper/izi_number.dart';

import '../../../helper/izi_validate.dart';

class SettingResponse {
  String? id;
  String? contactCenter;
  String? address;
  String? email;
  String? website;
  String? contact;
  int? hotline;
  String? description;
  String? title;
  String? keyword;
  String? schema;
  String? createdAt;
  String? updatedAt;

  SettingResponse(
      {this.id,
      this.title,
      this.description,
      this.keyword,
      this.schema,
      this.hotline,
      this.contact,
      this.createdAt,
      this.updatedAt});

  SettingResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    contactCenter = (json['contactCenter'] == null) ? null : json['contactCenter'].toString();

    address =
        (json['address'] == null) ? null : json['address'].toString();
    email = (json['email'] == null) ? null : json['email'].toString();
    website = (json['website'] == null) ? null : json['website'].toString();
    contact =
        (json['contact'] == null) ? null : json['contact'].toString();
    hotline = IZIValidate.nullOrEmpty(json['hotline'])
        ? null
        : IZINumber.parseInt(json['hotline']);
    contact = (json['contact'] == null) ? null : json['contact'].toString();

    description = (json['description'] == null) ? null : json['description'].toString();
    title = (json['title'] == null) ? null : json['title'].toString();
    keyword =(json['keyword'] == null) ? null : json['keyword'].toString();
      schema =(json['schema'] == null) ? null : json['schema'].toString();
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
    if (!IZIValidate.nullOrEmpty(contactCenter)) data['contactCenter'] = contactCenter;
    if (!IZIValidate.nullOrEmpty(address)) {
      data['address'] = address;
    }
    if (!IZIValidate.nullOrEmpty(email)) data['email'] = email;
    if (!IZIValidate.nullOrEmpty(website)) data['website'] = website;
    if (!IZIValidate.nullOrEmpty(hotline)) data['hotline'] = hotline;
    if (!IZIValidate.nullOrEmpty(contact)) data['contact'] = contact;
    if (!IZIValidate.nullOrEmpty(description)) data['description'] = description;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
        if (!IZIValidate.nullOrEmpty(keyword)) data['keyword'] = keyword;
    if (!IZIValidate.nullOrEmpty(schema)) data['schema'] = schema;
        if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
