// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:template/data/model/brand/brand_response.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

///
/// ProductResponse
///

class ProductResponse extends Options {
  List<String>? images;
  String? thumbnail;
  int? ratePoint;
  int? totalPoint;
  int? discountPercent;
  CategoryResponse? idCategory;
  BrandResponse? idBrand;
  String? name;
  String? description;
  String? content;
  List<SizesOption>? sizesOption;
  List<ColorsOption>? colorsOption;
  List<QuantityPrices>? quantityPrices;
  int? countSold;
  int? countRate;
  bool isCheckSelectPayment = false;
  List<String>? favorites;

  ProductResponse({
    this.idCategory,
    this.idBrand,
    this.name,
    this.description,
    this.content,
    this.discountPercent,
    this.sizesOption,
    this.colorsOption,
    this.quantityPrices,
    this.countSold,
    this.countRate,
    this.ratePoint,
    this.totalPoint,
    this.thumbnail,
    this.images,
    this.favorites,
    String? id,
  }) : super(id: id);

  ProductResponse.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idCategory = IZIValidate.nullOrEmpty(json['category'])
        ? null
        : json['category'] is String
            ? CategoryResponse(id: json['category'].toString())
            : CategoryResponse.fromJson(json['category'] as Map<String, dynamic>);
    idBrand = IZIValidate.nullOrEmpty(json['brand'])
        ? null
        : json['brand'] is String
            ? BrandResponse(id: json['brand'].toString())
            : BrandResponse.fromJson(json['brand'] as Map<String, dynamic>);
    name = IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
    description = IZIValidate.nullOrEmpty(json['description']) ? null : json['description'].toString();
    content = IZIValidate.nullOrEmpty(json['content']) ? null : json['content'].toString();
    discountPercent = IZIValidate.nullOrEmpty(json['discountPercent']) ? null : int.parse(json['discountPercent'].toString());
    sizesOption = IZIValidate.nullOrEmpty(json['sizes']) ? [] : (json['sizes'] as List).map((e) => SizesOption.fromJson(e as Map<String, dynamic>)).toList();
    colorsOption = IZIValidate.nullOrEmpty(json['colors']) ? [] : (json['colors'] as List).map((e) => ColorsOption.fromJson(e as Map<String, dynamic>)).toList();
    quantityPrices = IZIValidate.nullOrEmpty(json['quantityPrices']) ? [] : (json['quantityPrices'] as List).map((e) => QuantityPrices.fromJson(e as Map<String, dynamic>)).toList();
    countSold = IZIValidate.nullOrEmpty(json['countSold']) ? null : int.parse(json['countSold'].toString());
    countRate = IZIValidate.nullOrEmpty(json['countRate']) ? null : int.parse(json['countRate'].toString());
    ratePoint = IZIValidate.nullOrEmpty(json['ratePoint']) ? null : int.parse(json['ratePoint'].toString());
    totalPoint = IZIValidate.nullOrEmpty(json['totalPoint']) ? null : int.parse(json['totalPoint'].toString());
    thumbnail = IZIValidate.nullOrEmpty(json['thumbnail']) ? null : json['thumbnail'].toString();
    images = IZIValidate.nullOrEmpty(json['images']) ? null : (json['images'] as List).cast<String>().toList();
    favorites = IZIValidate.nullOrEmpty(json['favorites']) ? null : (json['favorites'] as List).cast<String>().toList();
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idCategory)) data['category'] = idCategory!.id;
    if (!IZIValidate.nullOrEmpty(idBrand)) data['brand'] = idBrand!.id;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(discountPercent)) {
      data['discountPercent'] = discountPercent;
    }
    if (!IZIValidate.nullOrEmpty(sizesOption)) {
      data['size'] = sizesOption!.map((e) => e.toJson()).toList();
    }
    if (!IZIValidate.nullOrEmpty(colorsOption)) {
      data['color'] = colorsOption!.map((e) => e.toJson()).toList();
    }
    if (!IZIValidate.nullOrEmpty(quantityPrices)) {
      data['quantityPrices'] = quantityPrices;
    }
    if (!IZIValidate.nullOrEmpty(countSold)) data['countSold'] = countSold;
    if (!IZIValidate.nullOrEmpty(countRate)) data['countRate'] = countRate;
    if (!IZIValidate.nullOrEmpty(ratePoint)) data['ratePoint'] = ratePoint;
    if (!IZIValidate.nullOrEmpty(totalPoint)) data['totalPoint'] = totalPoint;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(images)) data['images'] = images;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return (other is ProductResponse) && other.id == id && other.price == price && other.runtimeType == runtimeType;
  }

  // set lại hashcode của Object
  @override
  int get hashCode => id.hashCode;
}

///
/// Options
///

class Options {
  String? id;
  double? price;
  String? createdAt;
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
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}

// model cu
class OptionsSize extends Options {
  String? size;
  OptionsSize({
    this.size,
  });
  OptionsSize.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

// model cu

class OptionsTopping extends Options {
  String? topping;
  OptionsTopping.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    return data;
  }
}

///
/// SizesOption
///
class SizesOption {
  String? id;
  String? type;
  String? name;
  SizesOption.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    type = IZIValidate.nullOrEmpty(json['type']) ? null : json['type'].toString();
    name = IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return (other is SizesOption) && other.name == name && other.runtimeType == runtimeType;
  }

  // set lại hashcode của Object
  @override
  int get hashCode => name.hashCode;
}

///
/// ColorsOption
///
class ColorsOption {
  String? id;
  String? type;
  String? name;
  String? image;

  ColorsOption({this.id, this.type, this.name, this.image});
  ColorsOption.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    type = IZIValidate.nullOrEmpty(json['type']) ? null : json['type'].toString();
    name = IZIValidate.nullOrEmpty(json['name']) ? null : json['name'].toString();
    image = IZIValidate.nullOrEmpty(json['image']) ? null : json['image'].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(type)) data['type'] = type;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;

    return data;
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return (other is ColorsOption) && other.name == name;
  }

  // set lại hashcode của Object
  @override
  int get hashCode => name.hashCode;
}

///
/// QuantityPrices
///

class QuantityPrices extends Options {
  String? idColors;
  String? idSize;
  int? quantity;
  QuantityPrices({this.idColors, this.idSize, this.quantity});
  QuantityPrices.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idColors = IZIValidate.nullOrEmpty(json['color']) ? null : json['color'].toString();
    idSize = IZIValidate.nullOrEmpty(json['size']) ? null : json['size'].toString();
    quantity = IZIValidate.nullOrEmpty(json['quantity']) ? null : int.parse(json['quantity'].toString());
  }
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idColors)) data['color'] = idColors;
    if (!IZIValidate.nullOrEmpty(idSize)) data['size'] = idSize;
    if (!IZIValidate.nullOrEmpty(quantity)) data['quantity'] = quantity;
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;

    return data;
  }

  @override
  String toString() {
    return """
      {
      'color': $idColors,
      'size': $idSize,
      'price':$price,
      'id':$id,
      }""";
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }

    return (other is QuantityPrices) && other.runtimeType == runtimeType && other.idColors.toString() == idColors.toString() && other.idSize.toString() == idSize.toString() && other.price.toString() == price.toString();
  }

  // set lại hashcode của Object
  @override
  int get hashCode => price.hashCode;
}
