import 'dart:convert';

import '../../../helper/izi_number.dart';
import '../../../helper/izi_validate.dart';

class UserRequest {
  int? rankPoint;
  String? bankAccountName;
  int? bankAccountNumber;
  String? branchName;
  String? bankName;
  int? defaultAccount;
  bool? isGetOpen;
  bool? isVerified;
  bool? isGetNotification;
  String? address;
  String? typeUser;
  String? fullName;
  String? banner;
  String? avatar;
  bool? enableFCM;
  String? deviceID;
  String? typeRegister;
  String? phone;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? id;
  String? username;
  int? dateOfBirth;
  String? idProvince;
  String? idDistrict;
  String? idVillage;
  String? note;
  UserRequest({
    this.rankPoint,
    this.bankAccountName,
    this.bankAccountNumber,
    this.branchName,
    this.bankName,
    this.defaultAccount,
    this.isGetOpen,
    this.isVerified,
    this.isGetNotification,
    this.address,
    this.typeUser,
    this.fullName,
    this.banner,
    this.avatar,
    this.enableFCM,
    this.deviceID,
    this.typeRegister,
    this.phone,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.id,
    this.username,
    this.dateOfBirth,
    this.idProvince,
    this.idDistrict,
    this.idVillage,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(rankPoint)) 'rankPoint': rankPoint,
      if (!IZIValidate.nullOrEmpty(bankAccountName))
        'bankAccountName': bankAccountName,
      if (!IZIValidate.nullOrEmpty(bankAccountNumber))
        'bankAccountNumber': bankAccountNumber,
      if (!IZIValidate.nullOrEmpty(branchName)) 'branchName': branchName,
      if (!IZIValidate.nullOrEmpty(bankName)) 'bankName': bankName,
      if (!IZIValidate.nullOrEmpty(defaultAccount))
        'defaultAccount': defaultAccount,
      if (!IZIValidate.nullOrEmpty(isGetOpen)) 'isGetOpen': isGetOpen,
      if (!IZIValidate.nullOrEmpty(isVerified)) 'isVerified': isVerified,
      if (!IZIValidate.nullOrEmpty(isGetNotification))
        'isGetNotification': isGetNotification,
      if (!IZIValidate.nullOrEmpty(address)) 'address': address,
      if (!IZIValidate.nullOrEmpty(typeUser)) 'typeUser': typeUser,
      if (!IZIValidate.nullOrEmpty(fullName)) 'fullName': fullName,
      if (!IZIValidate.nullOrEmpty(banner)) 'banner': banner,
      if (!IZIValidate.nullOrEmpty(avatar)) 'avatar': avatar,
      if (!IZIValidate.nullOrEmpty(enableFCM)) 'enableFCM': enableFCM,
      if (!IZIValidate.nullOrEmpty(deviceID)) 'deviceID': deviceID,
      if (!IZIValidate.nullOrEmpty(typeRegister)) 'typeRegister': typeRegister,
      if (!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if (!IZIValidate.nullOrEmpty(role)) 'role': role,
      if (!IZIValidate.nullOrEmpty(createdAt)) 'createdAt': createdAt,
      if (!IZIValidate.nullOrEmpty(updatedAt)) 'updatedAt': updatedAt,
      if (!IZIValidate.nullOrEmpty(id)) 'id': id,
      if (!IZIValidate.nullOrEmpty(username)) 'username': username,
      if (!IZIValidate.nullOrEmpty(dateOfBirth)) 'dateOfBirth': dateOfBirth,
      if (!IZIValidate.nullOrEmpty(idProvince)) 'idProvince': idProvince,
      if (!IZIValidate.nullOrEmpty(idDistrict)) 'idDistrict': idDistrict,
      if (!IZIValidate.nullOrEmpty(idVillage)) 'idVillage': idVillage,
      if (!IZIValidate.nullOrEmpty(note)) 'note': note,
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      rankPoint: map['rankPoint'] != null
          ? IZINumber.parseInt(map['rankPoint'])
          : null,
      bankAccountName: map['bankAccountName'] != null
          ? map['bankAccountName'] as String
          : null,
      bankAccountNumber: map['bankAccountNumber'] != null
          ? IZINumber.parseInt(map['bankAccountNumber'])
          : null,
      branchName:
          map['branchName'] != null ? map['branchName'] as String : null,
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      defaultAccount: map['defaultAccount'] != null
          ? IZINumber.parseInt(map['defaultAccount'])
          : null,
      // isGetOpen: map['isGetOpen'] != null ? map['isGetOpen'] as String : null,
      isVerified: map['isVerified'] != null ? map['isVerified'] as bool : null,
      isGetNotification: map['isGetNotification'] != null
          ? map['isGetNotification'] as bool
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      typeUser: map['typeUser'] != null ? map['typeUser'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      banner: map['banner'] != null ? map['banner'] as String : null,
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
      enableFCM: map['enableFCM'] != null ? map['enableFCM'] as bool : null,
      deviceID: map['deviceID'] != null ? map['deviceID'] as String : null,
      typeRegister:
          map['typeRegister'] != null ? map['typeRegister'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      role: map['role'] != null ? map['role'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      id: map['_id'] != null ? map['_id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as int : null,
      idProvince:
          map['idProvince'] != null ? map['idProvince'] as String : null,
      idDistrict:
          map['idDistrict'] != null ? map['idDistrict'] as String : null,
      idVillage: map['idVillage'] != null ? map['idVillage'] as String : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
