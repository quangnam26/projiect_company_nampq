import 'dart:convert';
import 'package:template/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first


class SettingRequest{
  String? id;
  String? distanceFee;
  String? phone;
  String? bankAccountNumber;
  String? bankName;
  String? branchName;
  String? bankAccountName;
  String? createdAt;
  String? updatedAt;
  SettingRequest({
    this.id,
    this.distanceFee,
    this.phone,
    this.bankAccountNumber,
    this.bankName,
    this.branchName,
    this.bankAccountName,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if(!IZIValidate.nullOrEmpty(id)) '_id': id,
      if(!IZIValidate.nullOrEmpty(distanceFee)) 'distanceFee': distanceFee,
      if(!IZIValidate.nullOrEmpty(phone)) 'phone': phone,
      if(!IZIValidate.nullOrEmpty(bankAccountNumber)) 'bankAccountNumber': bankAccountNumber,
      if(!IZIValidate.nullOrEmpty(bankName)) 'bankName': bankName,
      if(!IZIValidate.nullOrEmpty(branchName)) 'branchName': branchName,
      if(!IZIValidate.nullOrEmpty(bankAccountName)) 'BankAccountName': bankAccountName,
      if(!IZIValidate.nullOrEmpty(createdAt)) 'createdAt': createdAt,
      if(!IZIValidate.nullOrEmpty(updatedAt)) 'updatedAt': updatedAt,
    };
  }

  factory SettingRequest.fromMap(Map<String, dynamic> map) {
    return SettingRequest(
      id: map['_id'] != null ? map['_id'] as String : null,
      distanceFee: map['distanceFee'] != null ? map['distanceFee'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      bankAccountNumber: map['bankAccountNumber'] != null ? map['bankAccountNumber'] as String : null,
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      branchName: map['branchName'] != null ? map['branchName'] as String : null,
      bankAccountName: map['BankAccountName'] != null ? map['BankAccountName'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingRequest.fromJson(String source) => SettingRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
