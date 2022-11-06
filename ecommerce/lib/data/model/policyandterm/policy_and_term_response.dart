import 'package:template/helper/izi_number.dart';

import '../../../helper/izi_validate.dart';

class PolicyAndTermResponse {
  String? id;
  String? title;
  String? image;
  String? description;
  String? content;
  int? postion;
  bool? isShow;
  String? createdAt;
  String? updatedAt;

  PolicyAndTermResponse(
      {this.id,
      this.title,
      this.image,
      this.description,
      this.content,
      this.postion,
      this.isShow,
      this.createdAt,
      this.updatedAt});

  PolicyAndTermResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    title = (json['title'] == null) ? null : json['title'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    description =
        (json['description'] == null) ? null : json['description'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();

    postion = IZIValidate.nullOrEmpty(json['postion'])
        ? null
        : IZINumber.parseInt(json['postion']);
    isShow =
        IZIValidate.nullOrEmpty(json['isShow']) ? null : json['isShow'] as bool;
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
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(postion)) data['postion'] = postion;
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
