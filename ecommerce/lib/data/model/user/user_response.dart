// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_number.dart';

class UserResponse {
  String? id;
  String? phone;
  String? password;
  String? username;
  String? fullName;
  int? born;
  String? avatar;
  String? idProvince;
  String? idDistrict;
  String? idVillage;
  String? address;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? gender;
  String? email;
  int? defaultAccount;
  UserResponse(
      {this.id,
      this.phone,
      this.password,
      this.username,
      this.fullName,
      this.born,
      this.avatar,
      this.idProvince,
      this.idDistrict,
      this.idVillage,
      this.address,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.gender,
      this.email,
      this.defaultAccount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'phone': phone,
      'password': password,
      'username': username,
      'fullName': fullName,
      'born': born,
      'avatar': avatar,
      'idProvince': idProvince,
      'idDistrict': idDistrict,
      'idVillage': idVillage,
      'address': address,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      "gender": gender,
      "email": email,
      "defaultAccount": defaultAccount
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['_id'] != null ? map['_id'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      born: map['born'] != null ? IZINumber.parseInt(map['born']) : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      idProvince:
          map['idProvince'] != null ? map['idProvince'] as String : null,
      idDistrict:
          map['idDistrict'] != null ? map['idDistrict'] as String : null,
      idVillage: map['idVillage'] != null ? map['idVillage'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      // gender: map['gender'] != null ? IZINumber.parseInt(map['gender']) : null,
      // gender: map['gender'] != null ? map['gender'] as String : null,
            gender: map['gender'] != null ? map['gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      defaultAccount: map['defaultAccount'] != null
          ? IZINumber.parseInt(map['defaultAccount'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
