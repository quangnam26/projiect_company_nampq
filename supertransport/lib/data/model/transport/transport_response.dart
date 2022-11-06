import 'dart:convert';

import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/vehicle/vehicle_response.dart';
import 'package:template/data/model/village/vilage_response.dart';

import '../../../helper/izi_number.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransportResponse {
  final String? id;
  final UserResponse? idUser;
  // 0: Cần xe,  1: Đi chung, 2: Gửi đồ, 3: Cho gửi đồ
  final int? transportType;
  final ProvinceResponse? idProvinceFrom;
  final ProvinceResponse? idProvinceTo;
  final DistrictResponse? idDistrictFrom;
  final DistrictResponse? idDistrictTo;
  final VillageResponse? idVillageFrom;
  final VillageResponse? idVillageTo;
  final String? addressFrom;
  final String? addressTo;
  final int? timeStart;
  final int? dateStart;
  final int? timeEnd;
  final int? dateEnd;
  final String? phone;
  final int? numberPeople;
  final String? description;
  final VehicleResponse? idVehicle;
  final int? numberEmptySeats;
  final int? numberSeats;
  final double? netWeight;
  final double? maxNetWeight;
  bool? isActive;
  final List<String>? images;
  final String? createdAt;
  final String? updatedAt;
  TransportResponse({
    this.id,
    this.idUser,
    this.transportType,
    this.idProvinceFrom,
    this.idProvinceTo,
    this.idDistrictFrom,
    this.idDistrictTo,
    this.idVillageFrom,
    this.idVillageTo,
    this.addressFrom,
    this.addressTo,
    this.timeStart,
    this.dateStart,
    this.timeEnd,
    this.dateEnd,
    this.phone,
    this.numberPeople,
    this.description,
    this.idVehicle,
    this.numberEmptySeats,
    this.numberSeats,
    this.netWeight,
    this.maxNetWeight,
    this.isActive,
    this.images,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'idUser':idUser,
      'transportType': transportType,
      'idProvinceFrom': idProvinceFrom,
      'idProvinceTo': idProvinceTo,
      'idDistrictFrom': idDistrictFrom,
      'idDistrictTo': idDistrictTo,
      'idVillageFrom': idVillageFrom,
      'idVillageTo': idVillageTo,
      'addressFrom': addressFrom,
      'addressTo': addressTo,
      'timeStart': timeStart,
      'dateStart': dateStart,
      'timeEnd': timeEnd,
      'dateEnd': dateEnd,
      'phone': phone,
      'numberPeople': numberPeople,
      'description': description,
      'idVehicle': idVehicle,
      'numberEmptySeats': numberEmptySeats,
      'numberSeats': numberSeats,
      'netWeight': netWeight,
      'maxNetWeight': maxNetWeight,
      'isActive': isActive,
      'images': images,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory TransportResponse.fromMap(Map<String, dynamic> map) {
    print('Tỉnh Prom: ${map['idDistrictTo']}');
    return TransportResponse(
      id: map['_id'] != null ? map['_id'] as String : null,
      idUser: map['idUser'] != null ? UserResponse.fromMap(map['idUser'] as Map<String, dynamic>) : null,
      transportType: map['transportType'] != null ? IZINumber.parseInt(map['transportType']) : 0,
      idProvinceFrom: map['idProvinceFrom'] != null ? ProvinceResponse.fromMap(map['idProvinceFrom'] as Map<String,dynamic>) : null,
      idProvinceTo: map['idProvinceTo'] != null ? ProvinceResponse.fromMap(map['idProvinceTo'] as Map<String,dynamic>) : null,
      idDistrictFrom: map['idDistrictFrom'] != null ? DistrictResponse.fromMap(map['idDistrictFrom'] as Map<String,dynamic>) : null,
      idDistrictTo: map['idDistrictTo'] != null ? DistrictResponse.fromMap(map['idDistrictTo'] as Map<String,dynamic>) : null,
      idVillageFrom: map['idVillageFrom'] != null ? VillageResponse.fromMap(map['idVillageFrom'] as Map<String,dynamic>) : null,
      idVillageTo: map['idVillageTo'] != null ? VillageResponse.fromMap(map['idVillageTo'] as Map<String,dynamic>) : null,
      addressFrom: map['addressFrom'] != null ? map['addressFrom'] as String : null,
      addressTo: map['addressTo'] != null ? map['addressTo'] as String : null,
      timeStart: map['timeStart'] != null ? IZINumber.parseInt(map['timeStart']) : null,
      dateStart: map['dateStart'] != null ? IZINumber.parseInt(map['dateStart']) : null,
      timeEnd: map['timeEnd'] != null ? IZINumber.parseInt(map['timeEnd']) : null,
      dateEnd: map['dateEnd'] != null ? IZINumber.parseInt(map['dateEnd']) : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      numberPeople: map['numberPeople'] != null ? IZINumber.parseInt(map['numberPeople']) : null,
      description: map['description'] != null ? map['description'] as String : null,
      idVehicle: map['idVehicle'] != null ? VehicleResponse.fromMap(map['idVehicle'] as Map<String, dynamic>) : null,
      numberEmptySeats: map['numberEmptySeats'] != null ? IZINumber.parseInt(map['numberEmptySeats']) : null,
      numberSeats: map['numberSeats'] != null ? IZINumber.parseInt(map['numberSeats']) : null,
      netWeight: map['netWeight'] != null ? IZINumber.parseDouble(map['netWeight']) : null,
      maxNetWeight: map['maxNetWeight'] != null ? IZINumber.parseDouble(map['maxNetWeight']) : null,
      // ignore: avoid_bool_literals_in_conditional_expressions
      isActive: map['isActive'] != null ? map['isActive'] as bool : false,
      images: map['images'] != null ? (map['images'] as List<dynamic>).map((e) => e.toString()).toList() : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportResponse.fromJson(String source) => TransportResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  TransportResponse copyWith({
    String? id,
    int? transportType,
    ProvinceResponse? idProvinceFrom,
    ProvinceResponse? idProvinceTo,
    DistrictResponse? idDistrictFrom,
    DistrictResponse? idDistrictTo,
    VillageResponse? idVillageFrom,
    VillageResponse? idVillageTo,
    String? addressFrom,
    String? addressTo,
    List<String>? images,
    int? timeStart,
    int? dateStart,
    int? timeEnd,
    int? dateEnd,
    String? phone,
    int? numberPeople,
    String? description,
    VehicleResponse? idVehicle,
    int? numberEmptySeats,
    int? numberSeats,
    double? netWeight,
    double? maxNetWeight,
    bool? isActive,
    String? createdAt,
    String? updatedAt,
  }) {
    return TransportResponse(
      id: id ?? this.id,
      transportType: transportType ?? this.transportType,
      idProvinceFrom: idProvinceFrom ?? this.idProvinceFrom,
      idProvinceTo: idProvinceTo ?? this.idProvinceTo,
      idDistrictFrom: idDistrictFrom ?? this.idDistrictFrom,
      idDistrictTo: idDistrictTo ?? this.idDistrictTo,
      idVillageFrom: idVillageFrom ?? this.idVillageFrom,
      idVillageTo: idVillageTo ?? this.idVillageTo,
      addressFrom: addressFrom ?? this.addressFrom,
      addressTo: addressTo ?? this.addressTo,
      timeStart: timeStart ?? this.timeStart,
      dateStart: dateStart ?? this.dateStart,
      timeEnd: timeEnd ?? this.timeEnd,
      dateEnd: dateEnd ?? this.dateEnd,
      phone: phone ?? this.phone,
      images: images ?? this.images,
      numberPeople: numberPeople ?? this.numberPeople,
      description: description ?? this.description,
      idVehicle: idVehicle ?? this.idVehicle,
      numberEmptySeats: numberEmptySeats ?? this.numberEmptySeats,
      numberSeats: numberSeats ?? this.numberSeats,
      netWeight: netWeight ?? this.netWeight,
      maxNetWeight: maxNetWeight ?? this.maxNetWeight,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static String toPopulate(){
    return 'idUser,idProvinceFrom,idProvinceTo,idDistrictFrom.idProvince,idDistrictTo.idProvince,idVillageFrom.idDistrict.idProvince,idVillageTo.idDistrict.idProvince,idVehicle';
  }

}
