// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:template/data/model/product/options/options.dart';
import 'package:template/helper/izi_validate.dart';

part 'options_topping.g.dart';

@HiveType(typeId: 12)
class OptionsTopping extends Options {
  @HiveField(4)
  String? topping;
  OptionsTopping({
    this.topping,
  });
  OptionsTopping.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    topping = IZIValidate.nullOrEmpty(json['topping']) ? null : json['topping'].toString();
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    id = null;
    Map<String, dynamic> data = super.toJson();
    data['topping'] = topping;
    return data;
  }
}
