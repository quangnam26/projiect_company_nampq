// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/geocode/distance.dart';
import 'package:template/data/model/group_product/group_product_response.dart';
import 'package:template/data/model/product/options/options.dart';
import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

@HiveType(typeId: 7)
class ProductHistoryResponse extends Options {
  @HiveField(16)
  bool? isActive;
  @HiveField(15)
  String? description;
  @HiveField(17)
  String? nameSearch;
  @HiveField(4)
  String? name;
  @HiveField(5)
  String? image;
  @HiveField(6)
  String? thumbnail;
  @HiveField(7)
  String? idUser;
  @HiveField(8)
  String? idCategory;
  @HiveField(9)
  String? idGroup;
  @HiveField(10)
  List<OptionsSize>? optionsSize;
  @HiveField(11)
  List<OptionsTopping>? optionsTopping;
  @HiveField(12)
  Distance? distanceMatrix;
  @HiveField(13)
  int? numberReviews;
  @HiveField(14)

  /// thêm số lượng sản phẩm trách vòng lặp sản phẩm trùng nhau.
  int? numberOfBuy;
  ProductHistoryResponse({
    this.isActive,
    this.description,
    this.nameSearch,
    this.name,
    this.image,
    this.thumbnail,
    this.idUser,
    this.idCategory,
    this.idGroup,
    this.optionsSize,
    this.optionsTopping,
    this.distanceMatrix,
    this.numberReviews,
    this.numberOfBuy,
  });

  ProductHistoryResponse.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
    // isActive = IZIValidate.nullOrEmpty(isActive) ? null : json['isActive'] as bool;
    description = IZIValidate.nullOrEmpty(json['description'])
        ? null
        : json['description'].toString();
    nameSearch = IZIValidate.nullOrEmpty(json['nameSearch'])
        ? null
        : json['nameSearch'].toString();
    name =
        IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
    image = IZIValidate.nullOrEmpty(json['image'])
        ? null
        : json['image'].toString();
    thumbnail = IZIValidate.nullOrEmpty(json['thumbnail'])
        ? null
        : json['thumbnail'].toString();
    numberReviews = IZIValidate.nullOrEmpty(json['numberReviews'])
        ? null
        : IZINumber.parseInt(json['numberReviews']);
    idUser = IZIValidate.nullOrEmpty(json['idUser'])
        ? null
        : json['idUser'].toString();
    idCategory = IZIValidate.nullOrEmpty(json['idCategory'])
        ? null
        : json['idCategory'].toString();
    idGroup = IZIValidate.nullOrEmpty(json['idGroup'])
        ? null
        : json['idGroup'].toString();

    optionsSize = IZIValidate.nullOrEmpty(json['optionsSize'])
        ? null
        : (json['optionsSize'] as List<dynamic>)
            .map((e) => OptionsSize.fromJson(e as Map<String, dynamic>))
            .toList();
    optionsTopping = IZIValidate.nullOrEmpty(json['optionsTopping'])
        ? null
        : (json['optionsTopping'] as List<dynamic>)
            .map((e) => OptionsTopping.fromJson(e as Map<String, dynamic>))
            .toList();
    distanceMatrix = IZIValidate.nullOrEmpty(json['distanceMatrix'])
        ? null
        : Distance.fromMap(json['distanceMatrix'] as Map<String, dynamic>);
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(isActive)) data['isActive'] = isActive;
    if (!IZIValidate.nullOrEmpty(description))
      data['description'] = description;
    if (!IZIValidate.nullOrEmpty(nameSearch)) data['nameSearch'] = nameSearch;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(numberReviews))
      data['numberReviews'] = numberReviews;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idCategory)) data['idCategory'] = idCategory;
    if (!IZIValidate.nullOrEmpty(idGroup)) data['idGroup'] = idGroup;
    if (!IZIValidate.nullOrEmpty(optionsSize))
      data['optionsSize'] = optionsSize!.map((e) => e.toJson());
    if (!IZIValidate.nullOrEmpty(optionsTopping))
      data['optionsTopping'] = optionsTopping!.map((e) => e.toJson());
    return data;
  }
}
