// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../helper/izi_number.dart';

class VehicleResponse {
  final String? id;
  final String? name;
  int? numberSheat;
  VehicleResponse({
     this.id,
     this.name,
     this.numberSheat,
  });
  

  VehicleResponse copyWith({
    String? id,
    String? name,
    int? numberSheat,
  }) {
    return VehicleResponse(
      id: id ?? this.id,
      name: name ?? this.name,
      numberSheat: numberSheat ?? this.numberSheat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'numberSheat': numberSheat,
    };
  }

  factory VehicleResponse.fromMap(Map<String, dynamic> map) {
    return VehicleResponse(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      numberSheat: map['numberSheat'] != null ? IZINumber.parseInt(map['nanumberSheatme']) : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleResponse.fromJson(String source) => VehicleResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => name ?? '';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VehicleResponse &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
