import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

import '../../../helper/izi_number.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransportRequest {
  final String? id;
  final String? idUser;
  final int? transportType;
  final String? idProvinceFrom;
  final String? idProvinceTo;
  final String? idDistrictFrom;
  final String? idDistrictTo;
  final String? idVillageFrom;
  final String? idVillageTo;
  final String? addressFrom;
  final String? addressTo;
  final int? timeStart;
  final int? dateStart;
  final int? timeEnd;
  final int? dateEnd;
  final String? phone;
  final int? numberPeople;
  final String? description;
  final String? idVehicle;
  final int? numberEmptySeats;
  final int? numberSeats;
  final double? netWeight;
  final double? maxNetWeight;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;
  final List<String>? images;
  TransportRequest({
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
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{

  
      if(!IZIValidate.nullOrEmpty(id))'_id': id,
      if(!IZIValidate.nullOrEmpty(idUser))'idUser': idUser,
      if(!IZIValidate.nullOrEmpty(transportType))'transportType': transportType,
      if(!IZIValidate.nullOrEmpty(idProvinceFrom))'idProvinceFrom': idProvinceFrom,
      if(!IZIValidate.nullOrEmpty(idProvinceTo))'idProvinceTo': idProvinceTo,
      if(!IZIValidate.nullOrEmpty(idDistrictFrom))'idDistrictFrom': idDistrictFrom,
      if(!IZIValidate.nullOrEmpty(idDistrictTo))'idDistrictTo': idDistrictTo,
      if(!IZIValidate.nullOrEmpty(idVillageFrom))'idVillageFrom': idVillageFrom,
      if(!IZIValidate.nullOrEmpty(idVillageTo))'idVillageTo': idVillageTo,
      if(!IZIValidate.nullOrEmpty(addressFrom))'addressFrom': addressFrom,
      if(!IZIValidate.nullOrEmpty(addressTo))'addressTo': addressTo,
      if(!IZIValidate.nullOrEmpty(timeStart))'timeStart': timeStart,
      if(!IZIValidate.nullOrEmpty(dateStart))'dateStart': dateStart,
      if(!IZIValidate.nullOrEmpty(timeEnd))'timeEnd': timeEnd,
      if(!IZIValidate.nullOrEmpty(dateEnd))'dateEnd': dateEnd,
      if(!IZIValidate.nullOrEmpty(phone))'phone': phone,
      if(!IZIValidate.nullOrEmpty(numberPeople))'numberPeople': numberPeople,
      if(!IZIValidate.nullOrEmpty(description))'description': description,
      if(!IZIValidate.nullOrEmpty(idVehicle))'idVehicle': idVehicle,
      if(!IZIValidate.nullOrEmpty(numberEmptySeats))'numberEmptySeats': numberEmptySeats,
      if(!IZIValidate.nullOrEmpty(numberSeats))'numberSeats': numberSeats,
      if(!IZIValidate.nullOrEmpty(netWeight))'netWeight': netWeight,
      if(!IZIValidate.nullOrEmpty(maxNetWeight))'maxNetWeight': maxNetWeight,
      if(!IZIValidate.nullOrEmpty(isActive))'isActive': isActive,
      if(!IZIValidate.nullOrEmpty(createdAt))'createdAt': createdAt,
      if(!IZIValidate.nullOrEmpty(updatedAt))'updatedAt': updatedAt,
      if(!IZIValidate.nullOrEmpty(images))'images':images,
    };
  }

  factory TransportRequest.fromMap(Map<String, dynamic> map) {
    return TransportRequest(
      // id: map['_id'] != null ? map['_id'] as String : null,
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      transportType: map['transportType'] != null
          ? IZINumber.parseInt(map['transportType'])
          : null,
      idProvinceFrom: map['idProvinceFrom'] != null
          ? map['idProvinceFrom'] as String
          : null,
      idProvinceTo:
          map['idProvinceTo'] != null ? map['idProvinceTo'] as String : null,
      idDistrictFrom: map['idDistrictFrom'] != null
          ? map['idDistrictFrom'] as String
          : null,
      idDistrictTo:
          map['idDistrictTo'] != null ? map['idDistrictTo'] as String : null,
      idVillageFrom:
          map['idVillageFrom'] != null ? map['idVillageFrom'] as String : null,
      idVillageTo:
          map['idVillageTo'] != null ? map['idVillageTo'] as String : null,
      addressFrom:
          map['addressFrom'] != null ? map['addressFrom'] as String : null,
      addressTo: map['addressTo'] != null ? map['addressTo'] as String : null,
      timeStart: map['timeStart'] != null
          ? IZINumber.parseInt(map['timeStart'])
          : null,
      dateStart: map['dateStart'] != null
          ? IZINumber.parseInt(map['dateStart'])
          : null,
      timeEnd:
          map['timeEnd'] != null ? IZINumber.parseInt(map['timeEnd']) : null,
      dateEnd:
          map['dateEnd'] != null ? IZINumber.parseInt(map['dateEnd']) : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      numberPeople: map['numberPeople'] != null
          ? IZINumber.parseInt(map['numberPeople'])
          : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      idVehicle: map['idVehicle'] != null ? map['idVehicle'] as String : null,
      numberEmptySeats: map['numberEmptySeats'] != null
          ? IZINumber.parseInt(map['numberEmptySeats'])
          : null,
      numberSeats: map['numberSeats'] != null
          ? IZINumber.parseInt(map['numberSeats'])
          : null,
      netWeight: map['netWeight'] != null
          ? IZINumber.parseDouble(map['netWeight'])
          : null,
      maxNetWeight: map['maxNetWeight'] != null
          ? IZINumber.parseDouble(map['maxNetWeight'])
          : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
      images: map['images'] != null
          ? (map['images'] as List<dynamic>).map((e) => e.toString()).toList()
          : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      // 03542972441
    );
  }

  String toJson() => json.encode(toMap());

  factory TransportRequest.fromJson(String source) =>
      TransportRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  TransportRequest copyWith({
    // String? id,
    String? idUser,
    int? transportType,
    String? idProvinceFrom,
    String? idProvinceTo,
    String? idDistrictFrom,
    String? idDistrictTo,
    String? idVillageFrom,
    String? idVillageTo,
    String? addressFrom,
    String? addressTo,
    int? timeStart,
    int? dateStart,
    int? timeEnd,
    int? dateEnd,
    String? phone,
    int? numberPeople,
    String? description,
    String? idVehicle,
    int? numberEmptySeats,
    int? numberSeats,
    double? netWeight,
    double? maxNetWeight,
    bool? isActive,
    List<String>? images,
    // String? createdAt,
    // String? updatedAt,
  }) {
    return TransportRequest(
      // id: id ?? this.id,
      idUser: idUser ?? this.idUser,
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
      numberPeople: numberPeople ?? this.numberPeople,
      description: description ?? this.description,
      idVehicle: idVehicle ?? this.idVehicle,
      numberEmptySeats: numberEmptySeats ?? this.numberEmptySeats,
      numberSeats: numberSeats ?? this.numberSeats,
      netWeight: netWeight ?? this.netWeight,
      maxNetWeight: maxNetWeight ?? this.maxNetWeight,
      isActive: isActive ?? this.isActive,
      // createdAt: createdAt ?? this.createdAt,
      // updatedAt: updatedAt ?? this.updatedAt,
      images: images ?? this.images,
    );
  }
}
