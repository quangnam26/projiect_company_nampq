// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

import '../../../helper/izi_number.dart';

class UserRequest {
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
  UserRequest({
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
      if(!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if(!IZIValidate.nullOrEmpty(password)) 'password': password,
      if(!IZIValidate.nullOrEmpty(username)) 'username': username,
      if(!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if(!IZIValidate.nullOrEmpty(dateOfBirth)) 'dateOfBirth': dateOfBirth,
      if(!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if(!IZIValidate.nullOrEmpty(idProvince)) 'idProvince': idProvince,
      if(!IZIValidate.nullOrEmpty(idDistrict)) 'idDistrict': idDistrict,
      if(!IZIValidate.nullOrEmpty(idVillage)) 'idVillage': idVillage,
      if(!IZIValidate.nullOrEmpty(address)) 'address': address,
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      dateOfBirth: map['dateOfBirth'] != null && map['dateOfBirth'] != 0 ? IZINumber.parseInt(map['dateOfBirth']) : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      idProvince: map['idProvince'] != null ? map['idProvince'] as String : null,
      idDistrict: map['idDistrict'] != null ? map['idDistrict'] as String : null,
      idVillage: map['idVillage'] != null ? map['idVillage'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) => UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
