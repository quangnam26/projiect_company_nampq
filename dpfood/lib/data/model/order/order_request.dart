// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

part 'order_request.g.dart';

@HiveType(typeId: 0)
class OrderRequest {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? idUser;
  @HiveField(2)
  String? idUserShipper;
  @HiveField(3)
  UserResponse? idUserShop;
  @HiveField(4)
  List<OrderProduct>? idProducts;
  @HiveField(5)
  String? idVoucher;
  @HiveField(6)
  double? finalPrice;
  @HiveField(7)
  double? shipPrice;
  @HiveField(8)
  double? promotionPrice;
  @HiveField(9)
  double? totalPrice;
  @HiveField(10)
  String? typePayment;
  @HiveField(11)
  String? statusPayment;
  @HiveField(12)
  String? status;
  @HiveField(13)
  String? codeOrder;
  @HiveField(14)
  Location? latLong;
  @HiveField(15)
  String? createdAt;
  @HiveField(16)
  String? updatedAt;
  @HiveField(17)
  String? description;
  String? billImage;
  int? distances;
  OrderRequest({
    this.id,
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
    this.billImage,
    this.distances,
  });
  OrderRequest.fromJson(Map<String, dynamic> json) {
    id = IZIValidate.nullOrEmpty(json['_id']) ? null : json['_id'].toString();
    idUser = IZIValidate.nullOrEmpty(json['idUser'])
        ? null
        : json['idUser'].toString();
    idUserShipper = IZIValidate.nullOrEmpty(json['idUserShipper'])
        ? null
        : json['idUserShipper'].toString();
    idUserShop = IZIValidate.nullOrEmpty(json['idUserShop'])
        ? null
        : UserResponse(id: json['idUserShop'].toString());
    //idProducts = IZIValidate.nullOrEmpty(json['idProducts']) ? null : (json['idProducts'] as List<dynamic>).map((e) => OrderProduct.fromJson(e as Map<String, dynamic>)).toList();
    idVoucher = IZIValidate.nullOrEmpty(json['idVoucher'])
        ? null
        : json['idVoucher'].toString();
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
    description = IZIValidate.nullOrEmpty(json['description'])
        ? null
        : json['description'].toString();
    codeOrder = IZIValidate.nullOrEmpty(json['codeOrder'])
        ? null
        : json['codeOrder'].toString();
    //latLong = IZIValidate.nullOrEmpty(json['latLong']) ? null : Location.fromMap(json['latLong'] as Map<String, dynamic>);
    createdAt = IZIValidate.nullOrEmpty(json['createdAt'])
        ? null
        : json['createdAt'].toString();
    updatedAt = IZIValidate.nullOrEmpty(json['updatedAt'])
        ? null
        : json['updatedAt'].toString();
    billImage = IZIValidate.nullOrEmpty(json['billImage'])
        ? null
        : json['billImage'].toString();
    distances = IZIValidate.nullOrEmpty(json['distances'])
        ? null
        : IZINumber.parseInt(json['distances']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idUserShipper))
      data['idUserShipper'] = idUserShipper;
    if (!IZIValidate.nullOrEmpty(idUserShop))
      data['idUserShop'] = idUserShop!.id;
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
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(idProducts))
      data['idProducts'] = idProducts!.map((e) => e.toJson()).toList();
    if (!IZIValidate.nullOrEmpty(description))
      data['description'] = description;
    if (!IZIValidate.nullOrEmpty(billImage)) data['billImage'] = billImage;
    if (!IZIValidate.nullOrEmpty(latLong)) data['latLong'] = latLong!.toMap();
    if (!IZIValidate.nullOrEmpty(distances)) data['distances'] = distances;
    return data;
  }
}

