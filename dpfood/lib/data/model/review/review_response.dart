// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:template/data/model/review/shipper_reactions.dart';
import 'package:template/data/model/review/shop_reactions.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ReviewResponse {
  String? id;
  UserResponse? idUser;
  UserResponse? idUserShipper;
  UserResponse? idUserShop;
  int? ratePoint;
  //{Delicious(Ngon Xỉu):0, WellPacked(Đóng gói tốt):0, VeryWorthTheMoney(Rất đáng tiền):0,Satisfied:0,QuickService(Phục vụ nhanh):0,Sad(Buổn rầu):0}
  ShopReactions? shopReactions;
  ShipperReactions? shipperReactions;
  String? content;
  List<String>? images;
  String? createdAt;
  String? updatedAt;
  ReviewResponse({
    this.id,
    this.idUser,
    this.idUserShipper,
    this.idUserShop,
    this.ratePoint,
    this.shopReactions,
    this.shipperReactions,
    this.content,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    idUser = (json['idUser'] == null) ? null : UserResponse.fromMap(json['idUser'] as Map<String, dynamic>);
    idUserShipper = (json['idUserShipper'] == null) ? null : UserResponse.fromMap(json['idUserShipper'] as Map<String, dynamic>);
    idUserShop = (json['idUserShop'] == null) ? null : UserResponse.fromMap(json['idUserShop'] as Map<String, dynamic>);
    ratePoint = (json['ratePoint'] == null) ? null : IZINumber.parseInt(json['ratePoint']);
    shopReactions = (json['shopReactions'] == null) ? null : ShopReactions.fromMap(json['shopReactions'] as Map<String, dynamic>);
    shipperReactions = (json['shipperReactions'] == null) ? null : ShipperReactions.fromMap(json['shipperReactions'] as Map<String,dynamic>);
    content = (json['content'] == null) ? null : json['content'].toString();
    images = (json['images'] == null) ? null : (json['images'] as List<dynamic>).map((e) => e.toString()).toList();
    createdAt = IZIValidate.nullOrEmpty(json['createdAt']) ? null : json['createdAt'].toString();
    updatedAt = IZIValidate.nullOrEmpty(json['updatedAt']) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idUserShipper)) data['idUserShipper'] = idUserShipper;
    if (!IZIValidate.nullOrEmpty(idUserShop)) data['idUserShop'] = idUserShop;
    if (!IZIValidate.nullOrEmpty(ratePoint)) data['ratePoint'] = ratePoint;
    if (!IZIValidate.nullOrEmpty(shopReactions)) data['shopReactions'] = shopReactions;
    if (!IZIValidate.nullOrEmpty(shipperReactions)) data['shipperReactions'] = shipperReactions;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(images)) data['images'] = images;
    return data;
  }
}
