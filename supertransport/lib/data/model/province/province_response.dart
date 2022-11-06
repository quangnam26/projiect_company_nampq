// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProvinceResponse {
  String? id;
  String? type;
  String? slug;
  String? name;
  String? createdAt;
  String? updatedAt;
  ProvinceResponse({
    this.id,
    this.type,
    this.slug,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'slug': slug,
      'name': name,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory ProvinceResponse.fromMap(Map<String, dynamic> map) {
    return ProvinceResponse(
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceResponse.fromJson(String source) => ProvinceResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => name ?? '';

}
