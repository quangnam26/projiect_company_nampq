// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/order/order_product/order_history_product.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class OrderHistoryResponse {
  String? id;
  UserResponse? idUser;
  String? idUserShipper;
  UserResponse? idUserShop;
  List<OrderHistoryProduct>? idProducts;
  VoucherResponse? idVoucher;
  double? finalPrice;
  double? shipPrice;
  double? promotionPrice;
  double? totalPrice;
  String? typePayment;
  String? statusPayment;
  String? status;
  String? codeOrder;
  Location? latLong;
  String? createdAt;
  String? updatedAt;
  String? description;
  bool? isReview;
  int? distances;
  OrderHistoryResponse(
      {this.id,
      this.idUser,
      this.idUserShipper,
      this.idUserShop,
      this.idProducts,
      this.idVoucher,
      this.finalPrice,
      this.shipPrice,
      this.promotionPrice,
      this.totalPrice,
      this.typePayment,
      this.statusPayment,
      this.status,
      this.codeOrder,
      this.latLong,
      this.createdAt,
      this.updatedAt,
      this.description,
      this.isReview = false,
      this.distances});

  OrderHistoryResponse.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    idUser = IZIValidate.nullOrEmpty(json['idUser'])
        ? null
        : UserResponse.fromMap(json['idUser'] as Map<String, dynamic>);
    idUserShipper = IZIValidate.nullOrEmpty(json['idUserShipper'])
        ? null
        : json['idUserShipper'].toString();
    idUserShop = IZIValidate.nullOrEmpty(json['idUserShop'])
        ? null
        : UserResponse.fromMap(json['idUserShop'] as Map<String, dynamic>);
    idProducts = IZIValidate.nullOrEmpty(json['idProducts'])
        ? null
        : (json['idProducts'] as List<dynamic>)
            .map((e) => OrderHistoryProduct.fromJson(e as Map<String, dynamic>))
            .toList();
    idVoucher = IZIValidate.nullOrEmpty(json['idVoucher'])
        ? null
        : VoucherResponse.fromJson(json['idVoucher'] as Map<String, dynamic>);
    finalPrice = IZIValidate.nullOrEmpty(json['finalPrice'])
        ? null
        : IZINumber.parseDouble(json['finalPrice']);
    shipPrice = IZIValidate.nullOrEmpty(json['shipPrice'])
        ? null
        : IZINumber.parseDouble(json['shipPrice']);
    promotionPrice = IZIValidate.nullOrEmpty(json['promotionPrice'])
        ? null
        : IZINumber.parseDouble(json['promotionPrice']);
    totalPrice = IZIValidate.nullOrEmpty(json['totalPrice'])
        ? null
        : IZINumber.parseDouble(json['totalPrice']);
    typePayment = IZIValidate.nullOrEmpty(json['typePayment'])
        ? null
        : json['typePayment'].toString();
    statusPayment = IZIValidate.nullOrEmpty(json['statusPayment'])
        ? null
        : json['statusPayment'].toString();
    status = IZIValidate.nullOrEmpty(json['status'])
        ? null
        : json['status'].toString();
    codeOrder = IZIValidate.nullOrEmpty(json['codeOrder'])
        ? null
        : json['codeOrder'].toString();
    description = IZIValidate.nullOrEmpty(json['description'])
        ? null
        : json['description'].toString();
    latLong = IZIValidate.nullOrEmpty(json['latLong'])
        ? null
        : Location.fromMap(json['latLong'] as Map<String, dynamic>);
    isReview = !IZIValidate.nullOrEmpty(json['isReview'])
        ? json['isReview'] as bool
        : null;
    createdAt = IZIValidate.nullOrEmpty(json['createdAt'])
        ? null
        : json['createdAt'].toString();
    updatedAt = IZIValidate.nullOrEmpty(json['updatedAt'])
        ? null
        : json['updatedAt'].toString();
    distances = IZIValidate.nullOrEmpty(json['distances'])
        ? null
        : IZINumber.parseInt(json['distances']);
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idUserShipper))
      data['idUserShipper'] = idUserShipper;
    if (!IZIValidate.nullOrEmpty(idUserShop)) data['idUserShop'] = idUserShop;
    if (!IZIValidate.nullOrEmpty(idProducts)) data['idProducts'] = idProducts;
    if (!IZIValidate.nullOrEmpty(idVoucher)) data['idVoucher'] = idVoucher;
    if (!IZIValidate.nullOrEmpty(finalPrice)) data['finalPrice'] = finalPrice;
    if (!IZIValidate.nullOrEmpty(shipPrice)) data['shipPrice'] = shipPrice;
    if (!IZIValidate.nullOrEmpty(promotionPrice))
      data['promotionPrice'] = promotionPrice;
    if (!IZIValidate.nullOrEmpty(totalPrice)) data['totalPrice'] = totalPrice;
    if (!IZIValidate.nullOrEmpty(typePayment))
      data['typePayment'] = typePayment;
    if (!IZIValidate.nullOrEmpty(statusPayment))
      data['statusPayment'] = statusPayment;
    if (!IZIValidate.nullOrEmpty(status)) data['status'] = status;
    if (!IZIValidate.nullOrEmpty(codeOrder)) data['codeOrder'] = codeOrder;
    if (!IZIValidate.nullOrEmpty(latLong)) data['latLong'] = latLong;
    if (!IZIValidate.nullOrEmpty(description))
      data['description'] = description;
    if (!IZIValidate.nullOrEmpty(isReview)) data['isReview'] = isReview;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(distances)) data['distances'] = distances;
    return data;
  }
}
