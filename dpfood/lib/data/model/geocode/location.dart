// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:template/helper/izi_validate.dart';
part 'location.g.dart';
@HiveType(typeId: 13)
class Location {
  @HiveField(0)
  String? lat;
  @HiveField(1)
  String? long;
  @HiveField(2)
  // Biến này dánh cho api của GOOG
  @HiveField(3)
  String? lng;
  @HiveField(4)
  String? startLat;
  @HiveField(5)
  String? startLong;
  @HiveField(6)
  String? endLat;
  @HiveField(7)
  String? endLong;
  Location({
    this.lat,
    this.long,
    this.startLat,
    this.startLong,
    this.endLat,
    this.endLong,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(lat))'lat': lat,
      if(!IZIValidate.nullOrEmpty(long))'long': long,
      if(!IZIValidate.nullOrEmpty(startLat))'startLat': startLat,
      if(!IZIValidate.nullOrEmpty(startLong))'startLong': startLong,
      if(!IZIValidate.nullOrEmpty(endLat))'endLat': endLat,
      if(!IZIValidate.nullOrEmpty(endLong))'endLong': endLong,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      // ignore: prefer_null_aware_operators
      lat: map['lat'] != null ? map['lat'].toString() : null,
      // ignore: prefer_null_aware_operators
      long: map['long'] != null ? map['long'].toString() : null,
      // ignore: prefer_null_aware_operators
      lng: map['lng'] != null ? map['lng'].toString() : null,
      startLat: map['startLat'] != null ? map['startLat'] as String : null,
      startLong: map['startLong'] != null ? map['startLong'] as String : null,
      endLat: map['endLat'] != null ? map['endLat'] as String : null,
      endLong: map['endLong'] != null ? map['endLong'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source) as Map<String, dynamic>);
}
