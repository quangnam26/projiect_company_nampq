// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/orders/shipping_history.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class OrderResponse {
  String? id;
  String? address;
  VoucherResponse? voucher;
  String? status;
  int? amountWithVoucher;
  int? amount;
  String? note;
  UserResponse? user;
  List<ItemsOptionResponse>? items;
  List<ShippingHistory>? shippingHistories;
  double? totalPrice;
  double? promotion;
  double? totalPayment;
  double? totalShipping;
  String? createdAt;
  String? updatedAt;
  OrderResponse({
    this.id,
    this.address,
    this.status,
    this.voucher,
    this.amountWithVoucher,
    this.amount,
    this.note,
    this.user,
    this.items,
    this.shippingHistories,
    this.totalPrice,
    this.promotion,
    this.totalPayment,
    this.totalShipping,
    this.createdAt,
    this.updatedAt,
  });

  OrderResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    address = (json['address'] == null) ? null : json['address'].toString();
    voucher = (json['voucher'] == null)
        ? null
        : json['voucher'].toString().length >= 24
            ? VoucherResponse(id: json['voucher'].toString())
            : VoucherResponse.fromJson(json['voucher'] as Map<String, dynamic>);
    status = (json['status'] == null) ? null : json['status'].toString();
    note = (json['note'] == null) ? null : json['note'].toString();
    amountWithVoucher = (json['amountWithVoucher'] == null)
        ? null
        : IZINumber.parseInt(json['amountWithVoucher']);
    amount =
        (json['amount'] == null) ? null : IZINumber.parseInt(json['amount']);
    totalPrice = (json['totalPrice'] == null)
        ? null
        : IZINumber.parseDouble(json['totalPrice']);
    promotion = (json['promotion'] == null)
        ? null
        : IZINumber.parseDouble(json['promotion']);
    totalPayment = (json['totalPayment'] == null)
        ? null
        : IZINumber.parseDouble(json['totalPayment']);
    totalShipping = (json['totalShipping'] == null)
        ? null
        : IZINumber.parseDouble(json['totalShipping']);
    user = json['user'] == null
        ? null
        : json['user'].toString().length >= 24
            ? UserResponse(id: json['user'].toString())
            : UserResponse.fromMap(json['user'] as Map<String, dynamic>);
    items = (json['items'] == null)
        ? null
        : (json['items'] as List)
            .map((e) => ItemsOptionResponse.fromJson(e as Map<String, dynamic>))
            .toList();
    shippingHistories = (json['shippingHistories'] == null)
        ? null
        : (json['shippingHistories'] as List<dynamic>)
            .map((e) => ShippingHistory.fromJson(e as Map<String, dynamic>))
            .toList();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt =
        (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(address)) data['address'] = address;
    if (!IZIValidate.nullOrEmpty(status)) data['status'] = status;
    if (!IZIValidate.nullOrEmpty(note)) data['note'] = note;
    if (!IZIValidate.nullOrEmpty(totalPrice)) data['totalPrice'] = totalPrice;
    if (!IZIValidate.nullOrEmpty(promotion)) data['promotion'] = promotion;
    if (!IZIValidate.nullOrEmpty(totalPayment)) {
      data['totalPayment'] = totalPayment;
    }
    if (!IZIValidate.nullOrEmpty(totalShipping)) {
      data['totalShipping'] = totalShipping;
    }
    // if (!IZIValidate.nullOrEmpty(voucher)) data['voucher'] = voucher;
    if (!IZIValidate.nullOrEmpty(amountWithVoucher)) {
      data['amountWithVoucher'] = amountWithVoucher;
    }
    if (!IZIValidate.nullOrEmpty(amount)) data['amount'] = amount;
    // if (!IZIValidate.nullOrEmpty(user)) data['user'] = user?.id;
    // if (!IZIValidate.nullOrEmpty(items)) data['items'] = items?.map((e) => e.toJson()).toList();
    // if (!IZIValidate.nullOrEmpty(shippingHistories)) data['shippingHistories'] = shippingHistories?.map((e) => e.toJson()).toList();
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  bool operator ==(covariant OrderResponse other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.address == address &&
        other.voucher == voucher &&
        other.status == status &&
        other.amountWithVoucher == amountWithVoucher &&
        other.amount == amount &&
        other.user == user &&
        other.items == items &&
        other.shippingHistories == shippingHistories &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        address.hashCode ^
        status.hashCode ^
        voucher.hashCode ^
        amountWithVoucher.hashCode ^
        amount.hashCode ^
        user.hashCode ^
        items.hashCode ^
        shippingHistories.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }

  @override
  String toString() {
    return 'OrderResponse(id: $id, address: $address, status: $status, amountWithVoucher: $amountWithVoucher, amount: $amount, user: $user, items: $items, shippingHistories: $shippingHistories, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
