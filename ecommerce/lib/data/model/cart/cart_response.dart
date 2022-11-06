// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_validate.dart';

class CartResponse {
  String? id;
  UserResponse? userResponse;
  List<ItemsOptionResponse>? itemsOption;

  CartResponse({this.id, this.userResponse, this.itemsOption});
  CartResponse.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    userResponse = IZIValidate.nullOrEmpty(json['user']) ||
            json['user'].toString().length == 24
        ? UserResponse(id: json['user'].toString())
        : UserResponse.fromMap(json['user'] as Map<String, dynamic>);
    itemsOption = IZIValidate.nullOrEmpty(json['items'])
        ? []
        : (json['items'] as List)
            .map((e) => ItemsOptionResponse.fromJson(e as Map<String, dynamic>))
            .toList();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(userResponse)) {
      data['user'] = userResponse!.id;
    }
    if (itemsOption != null) {
      data['items'] = itemsOption!.map((e) => e.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return """
      {
        'user': ${userResponse!.id},
        'items': $itemsOption,
      }""";
  }

  CartResponse copyWith({
    String? id,
    UserResponse? userResponse,
    List<ItemsOptionResponse>? itemsOption,
  }) {
    return CartResponse(
      id: id ?? this.id,
      userResponse: userResponse ?? this.userResponse,
      itemsOption: itemsOption ?? this.itemsOption,
    );
  }
}

class ItemsOptionResponse {
  String? id;
  String? idProductCart; // Auto
  ProductResponse? idProduct;
  QuantityPrices? quantityPrices;
  int? quantity;
  //
  bool? isSelected = false;
  TextEditingController? controller;

  ItemsOptionResponse(
      {this.id,
      this.idProduct,
      this.quantityPrices,
      this.quantity,
      this.isSelected = false});

  ItemsOptionResponse.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    idProductCart = IZIValidate.nullOrEmpty(json['idProductCart'])
        ? null
        : json['idProductCart'].toString();
    idProduct = IZIValidate.nullOrEmpty(json['product']) ||
            json['product'].toString().length == 24
        ? ProductResponse(id: json['product'].toString())
        : ProductResponse.fromJson(json['product'] as Map<String, dynamic>);
    quantityPrices = IZIValidate.nullOrEmpty(json['quantityPrices'])
        ? null
        : QuantityPrices.fromJson(
            json['quantityPrices'] as Map<String, dynamic>);
    quantity = IZIValidate.nullOrEmpty(json['quantity'])
        ? null
        : int.parse(json['quantity'].toString());
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(idProduct!.id)) {
      data['product'] = idProduct!.id;
    }

    if (!IZIValidate.nullOrEmpty(quantityPrices)) {
      data['quantityPrices'] = quantityPrices;
    }

    if (!IZIValidate.nullOrEmpty(id)) {
      data['idProductCart'] = id;
    }
    return data;
  }

  @override
  String toString() {
    return 'ItemsOptionResponse(id: $id, idProductCart: $idProductCart, idProduct: $idProduct, quantityPrices: $quantityPrices, quantity: $quantity)';
  }
}
