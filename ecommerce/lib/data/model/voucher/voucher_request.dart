import 'package:template/helper/izi_validate.dart';

import '../../../helper/izi_number.dart';
import '../category/category_response.dart';
import '../product/product_response.dart';
import '../user/user_response.dart';





class VoucherRequest {
  String? id;
  List<CategoryResponse>? idcategory;
  List<ProductResponse>? idproducts;
  List<UserResponse>? iduser;
  List<String>? users;
  int? price;
  int? minOrderAmount;
  int? maxDiscountAmount;
  int? discountPercent;
  int? quantity;
  int? quantityCountdown;
  int? fromDate;
  int? toDate;
  bool? isEnable;
  String? name;
  String? description;
  String? code;
  String? image;
  String? createdAt;
  String? updatedAt;
  bool isCkeck = false;
String? idVoucher;
  String? userId;
  VoucherRequest(
      {this.id,
      this.users,
      this.idcategory,
      this.idproducts,
      this.iduser,
      this.price,
      this.minOrderAmount,
      this.discountPercent,
      this.quantity,
      this.quantityCountdown,
      this.fromDate,
      this.toDate,
      this.isEnable,
      this.name,
      this.description,
      this.code,
      this.image,
      this.maxDiscountAmount,
      this.userId,
      this.idVoucher,
      this.createdAt,
      this.updatedAt});

  VoucherRequest.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;

    idcategory = IZIValidate.nullOrEmpty(json['categories'])
        ? []
        : (json['categories'] as List)
            .map((e) => e.toString().length == 24
                ? CategoryResponse()
                : CategoryResponse.fromJson(e as Map<String, dynamic>))
            .toList();

    idproducts = IZIValidate.nullOrEmpty(json['products'])
        ? []
        : (json['products'] as List)
            .map((e) => e.toString().length == 24
                ? ProductResponse()
                : ProductResponse.fromJson(e as Map<String, dynamic>))
            .toList();

    iduser = IZIValidate.nullOrEmpty(json['idUsers'])
        ? []
        : (json['idUsers'] as List)
            .map((e) => e.toString().length == 24
                ? UserResponse()
                : UserResponse.fromMap(e as Map<String, dynamic>))
            .toList();

    price = IZIValidate.nullOrEmpty(json['price'])
        ? null
        : IZINumber.parseInt(json['price']);
    minOrderAmount = IZIValidate.nullOrEmpty(json['minOrderAmount'])
        ? null
        : IZINumber.parseInt(json['minOrderAmount']);
    maxDiscountAmount = IZIValidate.nullOrEmpty(json['maxDiscountAmount'])
        ? null
        : IZINumber.parseInt(json['maxDiscountAmount']);
    quantity = IZIValidate.nullOrEmpty(json['quantity'])
        ? null
        : IZINumber.parseInt(json['quantity']);
    quantityCountdown = IZIValidate.nullOrEmpty(json['quantityCountdown'])
        ? null
        : IZINumber.parseInt(json['quantityCountdown']);
    fromDate = IZIValidate.nullOrEmpty(json['fromDate'])
        ? null
        : IZINumber.parseInt(json['fromDate']);
    toDate = IZIValidate.nullOrEmpty(json['toDate'])
        ? null
        : IZINumber.parseInt(json['toDate']);
    isEnable = IZIValidate.nullOrEmpty(json['isEnable'])
        ? null
        : json['isEnable'] is String
            ? json['isEnable'].toString() == 'yes'
            : json['isEnable'] as bool;
    description =
        (json['description'] == null) ? null : json['description'].toString();
    code = (json['code'] == null) ? null : json['code'].toString();
    name = (json['name'] == null) ? null : json['name'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
      userId = (json['userId'] == null) ? null : json['userId'].toString();
       idVoucher = (json['idVoucher'] == null) ? null : json['idVoucher'].toString();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt =
        (json['updatedAt'] == null) ? null : json['updatedAt'].toString();

    discountPercent = IZIValidate.nullOrEmpty(json['discountPercent'])
        ? null
        : IZINumber.parseInt(json['discountPercent']);

    users = !IZIValidate.nullOrEmpty(json['users'])
        ? (json['users'] as List<dynamic>).map((e) => e.toString()).toList()
        : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idcategory)) data['categories'] = idcategory;
    if (!IZIValidate.nullOrEmpty(idproducts)) data['products'] = idproducts;
    if (!IZIValidate.nullOrEmpty(iduser)) data['users'] = iduser;
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;
    if (!IZIValidate.nullOrEmpty(maxDiscountAmount)) {
      data['maxDiscountAmount'] = maxDiscountAmount;
    }
    if (!IZIValidate.nullOrEmpty(maxDiscountAmount)) {
      data['maxDiscountAmount'] = maxDiscountAmount;
    }

    if (!IZIValidate.nullOrEmpty(quantity)) data['quantity'] = quantity;
    if (!IZIValidate.nullOrEmpty(quantityCountdown)) {
      data['quantityCountdown'] = quantityCountdown;
    }
    if (!IZIValidate.nullOrEmpty(fromDate)) data['fromDate'] = fromDate;
    if (!IZIValidate.nullOrEmpty(toDate)) data['toDate'] = toDate;
    if (!IZIValidate.nullOrEmpty(isEnable)) data['isEnable'] = isEnable;

      if (!IZIValidate.nullOrEmpty(idVoucher)) data['idVoucher'] = idVoucher;
    if (!IZIValidate.nullOrEmpty(userId)) data['userId'] = userId;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(users)) data['users'] = users;
    if (!IZIValidate.nullOrEmpty(code)) data['code'] = code;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(discountPercent)) {
      data['discountPercent'] = discountPercent;
    }
    return data;
  }
}

