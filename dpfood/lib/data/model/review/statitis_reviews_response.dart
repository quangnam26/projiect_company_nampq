// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:template/data/model/review/shipper_reactions.dart';
import 'package:template/data/model/review/shop_reactions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
part 'statitis_reviews_response.g.dart';
@HiveType(typeId: 3)
class StatitisReviewResponse {
  @HiveField(0)
  int? totalRating;
  @HiveField(1)
  int? countRating;
  @HiveField(2)
  ShopReactions? shopReactions;
  @HiveField(3)
  ShipperReactions? shipperReactions;
  
  StatitisReviewResponse({
    this.totalRating,
    this.countRating,
    this.shopReactions,
    this.shipperReactions,
  });

  StatitisReviewResponse.fromJson(Map<String, dynamic> json) {
    totalRating = (json['totalRating'] == null) ? null : IZINumber.parseInt(json['totalRating']);
    countRating = (json['countRating'] == null) ? null : IZINumber.parseInt(json['countRating']);
    shopReactions = (json['shopReactions'] == null) ? null : ShopReactions.fromMap(json['shopReactions'] as Map<String, dynamic>);
    shipperReactions = (json['shipperReactions'] == null) ? null : ShipperReactions.fromMap(json['shipperReactions'] as Map<String,dynamic>);
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(totalRating)) data['totalRating'] = totalRating;
    if (!IZIValidate.nullOrEmpty(countRating)) data['countRating'] = countRating;
    if (!IZIValidate.nullOrEmpty(shopReactions)) data['shopReactions'] = shopReactions;
    if (!IZIValidate.nullOrEmpty(shipperReactions)) data['shipperReactions'] = shipperReactions;
    return data;
  }
}
