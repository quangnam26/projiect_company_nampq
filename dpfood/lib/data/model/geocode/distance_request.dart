// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/data/model/geocode/location.dart';
import 'package:template/helper/izi_validate.dart';

class DistanceRequest {
  Location? latLongStart;
  List<Location>? endLatLong;
  String? vehicle;
  DistanceRequest({
    this.latLongStart,
    this.endLatLong,
    this.vehicle,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(latLongStart))'latLongStart': latLongStart?.toMap(),
      if(!IZIValidate.nullOrEmpty(endLatLong))'endLatLong': endLatLong!.map((x) => x.toMap()).toList(),
      if(!IZIValidate.nullOrEmpty(vehicle))'vehicle': vehicle,
    };
  }

  factory DistanceRequest.fromMap(Map<String, dynamic> map) {
    return DistanceRequest(
      latLongStart: map['latLongStart'] != null ? Location.fromMap(map['latLongStart'] as Map<String,dynamic>) : null,
      endLatLong: map['endLatLong'] != null ? List<Location>.from((map['endLatLong'] as List<int>).map<Location?>((x) => Location.fromMap(x as Map<String,dynamic>),),) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistanceRequest.fromJson(String source) => DistanceRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
