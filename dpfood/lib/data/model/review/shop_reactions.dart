import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:template/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first


part 'shop_reactions.g.dart';
@HiveType(typeId: 4)
class ShopReactions {
  //ShopReactions{Delicious(Ngon Xỉu):0, WellPacked(Đóng gói tốt):0, 
  //VeryWorthTheMoney(Rất đáng tiền):0,
  //Satisfied:0,QuickService(Phục vụ nhanh):0,Sad(Buổn rầu):0}
  @HiveField(0)
  int? delicious;
  @HiveField(1)
  int? wellPacked;
  @HiveField(2)
  int? veryWorthTheMoney;
  @HiveField(3)
  int? satisfied;
  @HiveField(4)
  int? quickService;
  @HiveField(5)
  int? sad;
  ShopReactions({
    this.delicious,
    this.wellPacked,
    this.veryWorthTheMoney,
    this.satisfied,
    this.quickService,
    this.sad,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(delicious)) 'delicious': delicious,
      if(!IZIValidate.nullOrEmpty(wellPacked)) 'wellPacked': wellPacked,
      if(!IZIValidate.nullOrEmpty(veryWorthTheMoney)) 'veryWorthTheMoney': veryWorthTheMoney,
      if(!IZIValidate.nullOrEmpty(satisfied)) 'satisfied': satisfied,
      if(!IZIValidate.nullOrEmpty(quickService)) 'quickService': quickService,
      if(!IZIValidate.nullOrEmpty(sad)) 'sad': sad,
    };
  }

  factory ShopReactions.fromMap(Map<String, dynamic> map) {
    return ShopReactions(
      delicious: map['delicious'] != null ? map['delicious'] as int : null,
      wellPacked: map['wellPacked'] != null ? map['wellPacked'] as int : null,
      veryWorthTheMoney: map['veryWorthTheMoney'] != null ? map['veryWorthTheMoney'] as int : null,
      satisfied: map['satisfied'] != null ? map['satisfied'] as int : null,
      quickService: map['quickService'] != null ? map['quickService'] as int : null,
      sad: map['sad'] != null ? map['sad'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShopReactions.fromJson(String source) => ShopReactions.fromMap(json.decode(source) as Map<String, dynamic>);
}
