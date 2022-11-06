import 'package:template/data/model/review/review_response.dart';
import 'package:template/data/model/review/shipper_reactions.dart';
import 'package:template/data/model/review/shop_reactions.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ReviewRequest {
  String? id;
  String? idUser;
  String? idUserShipper;
  String? idUserShop;
  int? ratePoint;
  //{Delicious(Ngon Xỉu):0, WellPacked(Đóng gói tốt):0, VeryWorthTheMoney(Rất đáng tiền):0,Satisfied:0,QuickService(Phục vụ nhanh):0,Sad(Buổn rầu):0}
  ShopReactions? shopReactions;
  ShipperReactions? shipperReactions;
  String? content;
  List<String>? images;

  ReviewRequest({
    this.id,
    this.idUser,
    this.idUserShipper,
    this.idUserShop,
    this.ratePoint,
    this.shopReactions,
    this.shipperReactions,
    this.content,
    this.images,
  });

  @override
  ReviewRequest.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    idUser = (json['idUser'] == null) ? null : json['idUser'] as String;
    idUserShipper = (json['idUserShipper'] == null)
        ? null
        : json['idUserShipper'] as String;
    idUserShop =
        (json['idUserShop'] == null) ? null : json['idUserShop'] as String;
    ratePoint = (json['ratePoint'] == null)
        ? null
        : IZINumber.parseInt(json['ratePoint']);
    shopReactions = (json['shopReactions'] == null)
        ? null
        : ShopReactions.fromMap(json['shopReactions'] as Map<String, dynamic>);
    shipperReactions = (json['shipperReactions'] == null)
        ? null
        : ShipperReactions.fromMap(
            json['shipperReactions'] as Map<String, dynamic>);
    content = (json['content'] == null) ? null : json['content'].toString();
    images = (json['images'] == null)
        ? null
        : (json['images'] as List<dynamic>).map((e) => e.toString()).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idUserShipper))
      data['idUserShipper'] = idUserShipper;
    if (!IZIValidate.nullOrEmpty(idUserShop)) data['idUserShop'] = idUserShop;
    if (!IZIValidate.nullOrEmpty(ratePoint)) data['ratePoint'] = ratePoint;
    if (!IZIValidate.nullOrEmpty(shopReactions))
      data['shopReactions'] = shopReactions;
    if (!IZIValidate.nullOrEmpty(shipperReactions))
      data['shipperReactions'] = shipperReactions;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(images)) data['images'] = images;
    return data;
  }
}
