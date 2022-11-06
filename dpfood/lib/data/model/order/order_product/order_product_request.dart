import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class OrderProductRequest {
  String? idProduct;
  OptionsSize? optionsSize;
  List<OptionsTopping>? optionsTopping;
  int? amount;
  double? price;
  String? id;
  String? description;
  OrderProductRequest({
    this.idProduct,
    this.optionsSize,
    this.optionsTopping,
    this.amount,
    this.price,
    this.id,
    this.description,
  });
  OrderProductRequest.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    description = (json['description'] == null) ? null : json['description'] as String;
    idProduct = (json['idProduct'] == null) ? null : json['idProduct'].toString();
    optionsSize = (json['optionsSize'] == null) ? null : OptionsSize.fromJson(json['optionsSize'] as Map<String, dynamic>);
    optionsTopping = (json['optionsTopping'] == null) ? null : (json['optionsTopping'] as List<dynamic>).map((e) => OptionsTopping.fromJson(e as Map<String, dynamic>)).toList();
    amount = (json['amount'] == null) ? null : IZINumber.parseInt(json['amount']);
    price = (json['price'] == null) ? null : IZINumber.parseDouble(json['price']);
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idProduct)) data['idProduct'] = idProduct;
    if (!IZIValidate.nullOrEmpty(optionsSize)) data['optionsSize'] = optionsSize!.toJson();
    if (!IZIValidate.nullOrEmpty(optionsTopping)) data['optionsTopping'] = optionsTopping!.map((e) => e.toJson());
    if (!IZIValidate.nullOrEmpty(amount)) data['amount'] = amount;
    if (!IZIValidate.nullOrEmpty(description)) data['description'] = description;
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;
    return data;
  }
}
