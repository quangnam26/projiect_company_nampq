// ignore_for_file: public_member_api_docs, sort_constructors_first


import '../../../helper/izi_validate.dart';

class ShippingHistory {
  String? name;
  String? description;
  String? historyTime;
  ShippingHistory({
    this.name,
    this.description,
    this.historyTime,
  });

  ShippingHistory.fromJson(Map<String, dynamic> json) {
    name = (json['name'] == null) ? null : json['name'] as String;
    description = (json['description'] == null) ? null : json['description'].toString();
    historyTime = (json['historyTime'] == null) ? null : json['historyTime'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(description)) data['description'] = description;
    if (!IZIValidate.nullOrEmpty(historyTime)) data['historyTime'] = historyTime;
    return data;
  }

  @override
  bool operator ==(covariant ShippingHistory other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.description == description &&
      other.historyTime == historyTime;
  }

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ historyTime.hashCode;
}
