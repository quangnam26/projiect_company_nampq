import 'package:hive/hive.dart';
import 'package:template/data/model/product/options/options.dart';
import 'package:template/helper/izi_validate.dart';
part 'options_size.g.dart';
@HiveType(typeId: 11)
class OptionsSize extends Options {
  @HiveField(4)
  String? size;
  OptionsSize({
    this.size,
  });
  OptionsSize.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    size = IZIValidate.nullOrEmpty(json['size']) ? null : json['size'].toString();
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    id = null;
    final Map<String, dynamic> data = super.toJson();
    if (!IZIValidate.nullOrEmpty(size)) data["size"] = size;
    return data;
  }
}
