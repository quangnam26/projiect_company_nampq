import 'package:template/data/model/product/options/options.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class BannerResponse extends Options{
  bool? isActive;
  int? position;
  String? link;
  String? image;
  String? name;
  String? typeUser;
  BannerResponse.fromJson(Map<String, dynamic> json):super.fromJson(json) {
    isActive = IZIValidate.nullOrEmpty(json['isActive']) ? null : json['isActive'] as bool;
    position = IZIValidate.nullOrEmpty(json['position']) ? null : IZINumber.parseInt(json['position']);
    link = IZIValidate.nullOrEmpty(json['link']) ? null : json['link'].toString();
    image = IZIValidate.nullOrEmpty(json['image']) ? null : json['image'].toString();
    name = IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
    typeUser = IZIValidate.nullOrEmpty(json['typeUser']) ? null : json['typeUser'].toString();
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(isActive)) data['isActive'] = isActive;
    if (!IZIValidate.nullOrEmpty(position)) data['position'] = position;
    if (!IZIValidate.nullOrEmpty(link)) data['link'] = link;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(typeUser)) data['typeUser'] = typeUser;
    return data;
  }
}