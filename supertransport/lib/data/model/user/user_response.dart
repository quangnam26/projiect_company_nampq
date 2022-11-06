// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_number.dart';

class UserResponse {
  String? id;
  String? phone;
  String? password;
  String? username;
  String? fullName;
  int? dateOfBirth;
  String? avatar;
  String? idProvince;
  String? idDistrict;
  String? idVillage;
  String? address;
  UserResponse({
    this.id,
    this.phone,
    this.password,
    this.username,
    this.fullName,
    this.dateOfBirth,
    this.avatar,
    this.idProvince,
    this.idDistrict,
    this.idVillage,
    this.address,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'phone': phone,
      'password': password,
      'username': username,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth,
      'avatar': avatar,
      'idProvince': idProvince,
      'idDistrict': idDistrict,
      'idVillage': idVillage,
      'address': address,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      id: map['_id'] != null ? map['_id'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null ? IZINumber.parseInt(map['dateOfBirth']) : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      idProvince: map['idProvince'] != null ? map['idProvince'] as String : null,
      idDistrict: map['idDistrict'] != null ? map['idDistrict'] as String : null,
      idVillage: map['idVillage'] != null ? map['idVillage'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
