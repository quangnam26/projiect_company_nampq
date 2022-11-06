import 'package:hive/hive.dart';
import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/data/model/product/product_history_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

@HiveType(typeId: 6)
class OrderHistoryProduct {
  @HiveField(0)
  String? id;
  @HiveField(1)
  OptionsSize? optionsSize;
  @HiveField(2)
  List<OptionsTopping>? optionsTopping;
  @HiveField(3)
  int? amount;
  @HiveField(4)
  double? price;
  @HiveField(5)
  ProductHistoryResponse? idProduct;
  @HiveField(6)
  String? description;
  OrderHistoryProduct({
    this.idProduct,
    this.optionsSize,
    this.optionsTopping,
    this.amount,
    this.price,
    this.id,
    this.description,
  }) : super();
  OrderHistoryProduct.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    description =
        (json['description'] == null) ? null : json['description'] as String;
    idProduct = (json['idProduct'] == null)
        ? null
        : ProductHistoryResponse.fromJson(
            json['idProduct'] as Map<String, dynamic>);
    optionsSize = (json['optionsSize'] == null)
        ? null
        : OptionsSize.fromJson(json['optionsSize'] as Map<String, dynamic>);
    optionsTopping = (json['optionsTopping'] == null)
        ? null
        : (json['optionsTopping'] as List<dynamic>)
            .map((e) => OptionsTopping.fromJson(e as Map<String, dynamic>))
            .toList();
    amount =
        (json['amount'] == null) ? null : IZINumber.parseInt(json['amount']);
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idProduct)) data['idProduct'] = idProduct!.id;
    if (!IZIValidate.nullOrEmpty(optionsSize))
      data['optionsSize'] = optionsSize!.toJson();
    if (!IZIValidate.nullOrEmpty(optionsTopping))
      data['optionsTopping'] = optionsTopping!.map((e) => e.toJson());
    if (!IZIValidate.nullOrEmpty(amount)) data['amount'] = amount;
    if (!IZIValidate.nullOrEmpty(description))
      data['description'] = description;
    return data;
  }
}
