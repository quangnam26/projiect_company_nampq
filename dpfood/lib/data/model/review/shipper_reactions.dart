import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:template/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
part 'shipper_reactions.g.dart';

@HiveType(typeId: 5)
class ShipperReactions {
  @HiveField(0)
  int? satisfied;
  @HiveField(1)
  int? notSatisfied;
  ShipperReactions({
    this.satisfied,
    this.notSatisfied,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(satisfied)) 'satisfied': satisfied,
      if (!IZIValidate.nullOrEmpty(notSatisfied)) 'notSatisfied': notSatisfied,
    };
  }

  factory ShipperReactions.fromMap(Map<String, dynamic> map) {
    return ShipperReactions(
      satisfied: map['satisfied'] != null ? map['satisfied'] as int : null,
      notSatisfied:
          map['notSatisfied'] != null ? map['notSatisfied'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShipperReactions.fromJson(String source) =>
      ShipperReactions.fromMap(json.decode(source) as Map<String, dynamic>);
}
