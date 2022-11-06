import 'dart:convert';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class SettingResponse {
  String? id;
  double? distanceFee;
  String? phone;
  String? bankAccountNumber;
  String? bankName;
  String? branchName;
  String? bankAccountName;
  int? promotionShipper;
  int? promotionShop;
  double? distanceNearFee;
  double? distanceFarFee;
  double? stopPointFee;
  double? codFee;
  int? km;

  String? createdAt;
  String? updatedAt;
  SettingResponse({
    this.id,
    this.distanceFee = 0,
    this.phone,
    this.bankAccountNumber,
    this.bankName,
    this.branchName,
    this.bankAccountName,
    this.promotionShipper,
    this.promotionShop,
    this.distanceNearFee,
    this.distanceFarFee,
    this.stopPointFee,
    this.codFee,
    this.km,
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
      if(!IZIValidate.nullOrEmpty(promotionShipper)) 'promotionShipper': promotionShipper,
      if(!IZIValidate.nullOrEmpty(promotionShop)) 'promotionShop': promotionShop,
      if(!IZIValidate.nullOrEmpty(km)) 'km': km,
      if(!IZIValidate.nullOrEmpty(distanceNearFee)) 'distanceNearFee': distanceNearFee,
      if(!IZIValidate.nullOrEmpty(distanceFarFee)) 'distanceFarFee': distanceFarFee,
      if(!IZIValidate.nullOrEmpty(stopPointFee)) 'stopPointFee': stopPointFee,
      if(!IZIValidate.nullOrEmpty(codFee)) 'codFee': codFee,
      if(!IZIValidate.nullOrEmpty(createdAt)) 'createdAt': createdAt,
      if(!IZIValidate.nullOrEmpty(updatedAt)) 'updatedAt': updatedAt,
    };
  }

  factory SettingResponse.fromMap(Map<String, dynamic> map) {
    return SettingResponse(
      id: map['_id'] != null ? map['_id'] as String : null,
      distanceFee: map['distanceFee'] != null ? IZINumber.parseDouble(map['distanceFee']) : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      bankAccountNumber: map['bankAccountNumber'] != null ? map['bankAccountNumber'] as String : null,
      bankName: map['bankName'] != null ? map['bankName'] as String : null,
      branchName: map['branchName'] != null ? map['branchName'] as String : null,
      bankAccountName: map['BankAccountName'] != null ? map['BankAccountName'] as String : null,
      promotionShipper: map['promotionShipper'] != null ? IZINumber.parseInt(map['promotionShipper']) : null,
      km: map['km'] != null ? IZINumber.parseInt(map['km']) : 0,
      promotionShop: map['promotionShop'] != null ? IZINumber.parseInt(map['promotionShop']) : null,
      distanceNearFee: map['distanceNearFee'] != null ? IZINumber.parseDouble(map['distanceNearFee']) : null,
      distanceFarFee: map['distanceFarFee'] != null ? IZINumber.parseDouble(map['distanceFarFee']) : null,
      stopPointFee: map['stopPointFee'] != null ? IZINumber.parseDouble(map['stopPointFee']) : null,
      codFee: map['codFee'] != null ? IZINumber.parseDouble(map['codFee']) : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingResponse.fromJson(String source) => SettingResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
