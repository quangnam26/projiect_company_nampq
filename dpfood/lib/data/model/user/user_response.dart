// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/review/statitis_reviews_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

part 'user_response.g.dart';

@HiveType(typeId: 2)
class UserResponse {
  @HiveField(0)
  int? rankPoint;
  @HiveField(1)
  String? bankAccountName;
  @HiveField(2)
  int? bankAccountNumber;
  @HiveField(3)
  String? branchName;
  @HiveField(4)
  String? bankName;
  @HiveField(5)
  int? defaultAccount;
  @HiveField(6)
  bool? isGetOpen;
  @HiveField(7)
  bool? isVerified;
  @HiveField(8)
  bool? isGetNotification;
  @HiveField(9)
  String? address;
  @HiveField(10)
  String? typeUser;
  @HiveField(11)
  String? fullName;
  @HiveField(12)
  String? banner;
  @HiveField(13)
  String? avatar;
  @HiveField(14)
  bool? enableFCM;
  @HiveField(15)
  String? deviceID;
  @HiveField(16)
  String? typeRegister;
  @HiveField(17)
  String? phone;
  @HiveField(18)
  String? role;
  @HiveField(19)
  String? createdAt;
  @HiveField(20)
  String? updatedAt;
  @HiveField(21)
  String? id;
  @HiveField(22)
  String? username;
  @HiveField(23)
  int? dateOfBirth;
  @HiveField(24)
  String? idProvince;
  @HiveField(25)
  String? idDistrict;
  @HiveField(26)
  String? idVillage;
  @HiveField(27)
  Location? latLong;
  @HiveField(28)
  StatitisReviewResponse? statitisReviews;
  @HiveField(29)
  int? numberOfSale;

  String? note;
  UserResponse({
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
    this.statitisReviews,
    this.numberOfSale = 0,
    this.latLong,
    this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(rankPoint)) 'rankPoint': rankPoint,
      if (!IZIValidate.nullOrEmpty(bankAccountName)) 'bankAccountName': bankAccountName,
      if (!IZIValidate.nullOrEmpty(bankAccountNumber)) 'bankAccountNumber': bankAccountNumber,
      if (!IZIValidate.nullOrEmpty(branchName)) 'branchName': branchName,
      if (!IZIValidate.nullOrEmpty(bankName)) 'bankName': bankName,
      if (!IZIValidate.nullOrEmpty(defaultAccount)) 'defaultAccount': defaultAccount,
      if (!IZIValidate.nullOrEmpty(isGetOpen)) 'isGetOpen': isGetOpen,
      if (!IZIValidate.nullOrEmpty(isVerified)) 'isVerified': isVerified,
      if (!IZIValidate.nullOrEmpty(isGetNotification)) 'isGetNotification': isGetNotification,
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
      if (!IZIValidate.nullOrEmpty(statitisReviews))
        'statitisReviews': statitisReviews,
      if (!IZIValidate.nullOrEmpty(numberOfSale)) 'numberOfSale': numberOfSale,
      if (!IZIValidate.nullOrEmpty(latLong)) 'latLong': latLong,
      if (!IZIValidate.nullOrEmpty(note)) 'note': note,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      rankPoint: !IZIValidate.nullOrEmpty(map['rankPoint'])
          ? IZINumber.parseInt(map['rankPoint'])
          : null,
      bankAccountName: !IZIValidate.nullOrEmpty(map['bankAccountName'])
          ? map['bankAccountName'] as String
          : null,
      bankAccountNumber: !IZIValidate.nullOrEmpty(map['bankAccountNumber'])
          ? IZINumber.parseInt(map['bankAccountNumber'])
          : null,
      branchName: !IZIValidate.nullOrEmpty(map['branchName'])
          ? map['branchName'] as String
          : null,
      bankName: !IZIValidate.nullOrEmpty(map['bankName'])
          ? map['bankName'] as String
          : null,
      defaultAccount: !IZIValidate.nullOrEmpty(map['defaultAccount'])
          ? IZINumber.parseInt(map['defaultAccount'])
          : null,
      // ignore: avoid_bool_literals_in_conditional_expressions
      isGetOpen: !IZIValidate.nullOrEmpty(map['isGetOpen']) != null ? map['isGetOpen'] as bool : false,
      // ignore: avoid_bool_literals_in_conditional_expressions
      isVerified: !IZIValidate.nullOrEmpty(map['isVerified'])
          ? map['isVerified'] is bool
              ? map['isVerified'] as bool
              : false
          : null,
      isGetNotification: !IZIValidate.nullOrEmpty(map['isGetNotification']) ? map['isGetNotification'] as bool : null,
      address: !IZIValidate.nullOrEmpty(map['address']) ? map['address'] as String : null,
      typeUser: !IZIValidate.nullOrEmpty(map['typeUser']) ? map['typeUser'] as String : null,
      fullName: !IZIValidate.nullOrEmpty(map['fullName']) ? map['fullName'] as String : null,
      banner: !IZIValidate.nullOrEmpty(map['banner']) ? map['banner'] as String : null,
      avatar: !IZIValidate.nullOrEmpty(map['avatar']) ? map['avatar'] as String : null,
      enableFCM: !IZIValidate.nullOrEmpty(map['enableFCM']) ? map['enableFCM'] as bool : null,
      deviceID: !IZIValidate.nullOrEmpty(map['deviceID']) ? map['deviceID'] as String : null,
      typeRegister: !IZIValidate.nullOrEmpty(map['typeRegister']) ? map['typeRegister'] as String : null,
      phone: !IZIValidate.nullOrEmpty(map['phone']) ? map['phone'] as String : null,
      role: !IZIValidate.nullOrEmpty(map['role']) ? map['role'] as String : null,
      createdAt: !IZIValidate.nullOrEmpty(map['createdAt']) ? map['createdAt'] as String : null,
      updatedAt: !IZIValidate.nullOrEmpty(map['updatedAt']) ? map['updatedAt'] as String : null,
      id: !IZIValidate.nullOrEmpty(map['_id']) ? map['_id'] as String : null,
      username: !IZIValidate.nullOrEmpty(map['username'])
          ? map['username'] as String
          : null,
      dateOfBirth: !IZIValidate.nullOrEmpty(map['dateOfBirth'])
          ? map['dateOfBirth'] as int
          : null,
      idProvince: !IZIValidate.nullOrEmpty(map['idProvince'])
          ? map['idProvince'] as String
          : null,
      idDistrict: !IZIValidate.nullOrEmpty(map['idDistrict'])
          ? map['idDistrict'] as String
          : null,
      idVillage: !IZIValidate.nullOrEmpty(map['idVillage'])
          ? map['idVillage'] as String
          : null,
      note:
          !IZIValidate.nullOrEmpty(map['note']) ? map['note'] as String : null,
      statitisReviews: !IZIValidate.nullOrEmpty(map['statitisReviews'])
          ? StatitisReviewResponse.fromJson(
              map['statitisReviews'] as Map<String, dynamic>)
          : null,
      numberOfSale: !IZIValidate.nullOrEmpty(map['numberOfSale'])
          ? IZINumber.parseInt(map['numberOfSale'])
          : 0,
      latLong: !IZIValidate.nullOrEmpty(map['latLong'])
          ? Location.fromMap(map['latLong'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) => UserResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
