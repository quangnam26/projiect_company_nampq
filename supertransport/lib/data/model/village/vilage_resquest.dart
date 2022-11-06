import 'dart:convert';


// ignore_for_file: public_member_api_docs, sort_constructors_first


class VillageRequest{
  final String? id;
  final String? type;
  final String? slug;
  final String? name;
  final String? idDistrict;
  final String? createdAt;
  final String? updatedAt;
  VillageRequest({
    this.id,
    this.type,
    this.slug,
    this.name,
    this.idDistrict,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'type': type,
      'slug': slug,
      'name': name,
      'idDistrict': idDistrict,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  factory VillageRequest.fromMap(Map<String, dynamic> map) {
    return VillageRequest(
      id: map['_id'] != null ? map['_id'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      slug: map['slug'] != null ? map['slug'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      idDistrict:  map['idDistrict'] != null ? map['idDistrict'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory VillageRequest.fromJson(String source) => VillageRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  VillageRequest copyWith({
    String? id,
    String? type,
    String? slug,
    String? name,
    String? idDistrict,
    String? createdAt,
    String? updatedAt,
  }) {
    return VillageRequest(
      id: id ?? this.id,
      type: type ?? this.type,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      idDistrict: idDistrict ?? this.idDistrict,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
