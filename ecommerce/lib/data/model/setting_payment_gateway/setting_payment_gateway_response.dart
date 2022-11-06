import '../../../helper/izi_validate.dart';

class SettingPayMentGateWayResponse {
  String? id;
  String? name;
  String? image;
  String? description;
  String? content;
  String? type;
  String? isEnable;
  SettingPayMentGateWayResponse(
      {this.id,
      this.name,
      this.image,
      this.description,
      this.content,
      this.type,
      this.isEnable});

  SettingPayMentGateWayResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    name = (json['title'] == null) ? null : json['name'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    description =
        (json['description'] == null) ? null : json['description'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();
    type = (json['type'] == null) ? null : json['type'].toString();
    isEnable = (json['isEnable'] == null) ? null : json['isEnable'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(name)) data['title'] = name;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    if (!IZIValidate.nullOrEmpty(isEnable)) data['isEnable'] = isEnable;

    return data;
  }
}

enum Type { MOMO, ATM, VISA, COD }
