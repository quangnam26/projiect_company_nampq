// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

import '../../../helper/izi_number.dart';

class UserRequest {
  String? id;
  String? phone;
  String? password;
  String? newPassword;
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
  String? otpCode;
 
  int? defaultAccount;
  UserRequest(
      {this.id,
      this.phone,
      this.password,
      this.newPassword,
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
      this.otpCode,
      this.defaultAccount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      //  if (!IZIValidate.nullOrEmpty(phone)) 'id': id,
      if (!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if (!IZIValidate.nullOrEmpty(password)) 'password': password,
      if (!IZIValidate.nullOrEmpty(newPassword)) 'newPassword': newPassword,

      if (!IZIValidate.nullOrEmpty(username)) 'username': username,
      if (!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if (!IZIValidate.nullOrEmpty(born)) 'born': born,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(idProvince)) 'idProvince': idProvince,
      if (!IZIValidate.nullOrEmpty(idDistrict)) 'idDistrict': idDistrict,
      if (!IZIValidate.nullOrEmpty(idVillage)) 'idVillage': idVillage,
      if (!IZIValidate.nullOrEmpty(address)) 'address': address,
      if (!IZIValidate.nullOrEmpty(role)) 'role': role,
      if (!IZIValidate.nullOrEmpty(createdAt)) 'createdAt': createdAt,
      if (!IZIValidate.nullOrEmpty(updatedAt)) 'updatedAt': updatedAt,
      if (!IZIValidate.nullOrEmpty(gender)) 'gender': gender,
      if (!IZIValidate.nullOrEmpty(email)) 'email': email,
      if (!IZIValidate.nullOrEmpty(otpCode)) 'otpCode': otpCode,
      if (!IZIValidate.nullOrEmpty(defaultAccount))
        'defaultAccount': defaultAccount,
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      id: map['_id'] != null ? map['_id'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      newPassword:
          map['newPassword'] != null ? map['newPassword'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      born: map['born'] != null && map['born'] != 0
          ? IZINumber.parseInt(map['born'])
          : null,
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
      gender: map['gender'] != null ? map['gender'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      otpCode: map['otpCode'] != null ? map['otpCode'] as String : null,
      defaultAccount:
          map['defaultAccount'] != null && map['defaultAccount'] != 0
              ? IZINumber.parseInt(map['defaultAccount'])
              : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
