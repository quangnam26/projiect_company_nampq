// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VehicleRequest {
  final String? id;
  final String? name;
  VehicleRequest({
     this.id,
     this.name,
  });
  

  VehicleRequest copyWith({
    String? id,
    String? name,
  }) {
    return VehicleRequest(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'name': name,
    };
  }

  factory VehicleRequest.fromMap(Map<String, dynamic> map) {
    return VehicleRequest(
      id: map['_id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleRequest.fromJson(String source) => VehicleRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'VehicleRequest(_id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is VehicleRequest &&
      other.id == id &&
      other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
