import 'package:hive/hive.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

part 'options.g.dart';

@HiveType(typeId: 10)
class Options {
  @HiveField(0)
  String? id;
  @HiveField(1)
  double? price;
  @HiveField(2)
  String? createdAt;
  @HiveField(3)
  String? updatedAt;
  Options({
    this.id,
    this.price,
    this.createdAt,
    this.updatedAt,
  });
  Options.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    price = (json['price'] == null) ? null : IZINumber.parseDouble(json['price']);
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(price) && price! >= 0) data['price'] = price;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
