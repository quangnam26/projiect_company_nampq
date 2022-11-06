import '../../../helper/izi_validate.dart';

class SettingBankResponse {
  String? id;
  bool? isEnable;
  String? holder;
  String? accountNumber;
  String? image;
  String? name;
  String? shortName;
  String? createdAt;
  String? updatedAt;
  SettingBankResponse({
    this.id,
    this.isEnable,
    this.holder,
    this.accountNumber,
    this.image,
    this.name,
    this.shortName,
    this.createdAt,
    this.updatedAt,
  });

  SettingBankResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    isEnable = (json['isEnable'] == null) ? null : json['isEnable'] as bool;
    holder = (json['holder'] == null) ? null : json['holder'].toString();
    accountNumber = (json['accountNumber'] == null)
        ? null
        : json['accountNumber'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    shortName =
        (json['shortName'] == null) ? null : json['shortName'].toString();

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
    if (!IZIValidate.nullOrEmpty(isEnable)) data['isEnable'] = isEnable;
    if (!IZIValidate.nullOrEmpty(holder)) data['holder'] = holder;
    if (!IZIValidate.nullOrEmpty(accountNumber)) {
      data['accountNumber'] = accountNumber;
    }
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(shortName)) data['shortName'] = shortName;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
