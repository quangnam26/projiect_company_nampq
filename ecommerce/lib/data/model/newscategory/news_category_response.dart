import '../../../helper/izi_validate.dart';

class NewsCategoryResponse {
  String? id;
  String? name;
  String? image;
  String? postion;
  bool? isShow;
  String? createdAt;
  String? updatedAt;
  NewsCategoryResponse(
      {this.id,
      this.name,
      this.image,
      this.postion,
      this.isShow,
      this.createdAt,
      this.updatedAt});

  NewsCategoryResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    name = (json['name'] == null) ? null : json['name'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    postion = (json['postion'] == null) ? null : json['postion'].toString();
    isShow = (json['isShow'] == null) ? null : json['isShow'] as bool;
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
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(postion)) data['postion'] = postion;
    if (!IZIValidate.nullOrEmpty(isShow)) data['isShow'] = isShow;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return name.toString();
  }
}
