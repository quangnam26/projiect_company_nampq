// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DistrictRequest {
  final String? id;
  final String? type;
  final String? slug;
  final String? name;
  final String? idProvince;
  final String? createdAt;
  final String? updatedAt;
  DistrictRequest({
    this.id,
    this.type,
    this.slug,
    this.name,
    this.idProvince,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'slug': slug,
      'name': name,
      'idProvince': idProvince,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory DistrictRequest.fromMap(Map<String, dynamic> map) {
    return DistrictRequest(
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      idProvince: map['idProvince'] != null ? map['idProvince'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DistrictRequest.fromJson(String source) => DistrictRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
