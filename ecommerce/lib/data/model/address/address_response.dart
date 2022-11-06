import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/village/vilage_response.dart';

import '../../../helper/izi_validate.dart';

class AddressResponse {
  String? id;
  UserResponse? user;
  ProvinceResponse? province;
  DistrictResponse? district;
  VillageResponse? village;
  String? addressDetail;
  String? fullName;
  String? phone;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;

  AddressResponse({
    this.id,
    this.user,
    this.province,
    this.district,
    this.village,
    this.addressDetail,
    this.fullName,
    this.isDefault,
    this.phone,
    this.createdAt,
    this.updatedAt,
  });

  AddressResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    user = (json['idUser'] == null) ? null : UserResponse.fromMap(json['idUser'] as Map<String, dynamic>);
    province = (json['province'] == null || json['province'].toString().length == 24) ? ProvinceResponse(id: json['province'].toString()) : ProvinceResponse.fromMap(json['province'] as Map<String, dynamic>);
    district = (json['district'] == null || json['district'].toString().length == 24) ? DistrictResponse(id: json['district'].toString()) : DistrictResponse.fromMap(json['district'] as Map<String, dynamic>);
    village = (json['village'] == null || json['village'].toString().length == 24) ? VillageResponse(id: json['village'].toString()) : VillageResponse.fromMap(json['village'] as Map<String, dynamic>);
    addressDetail = (json['addressDetail'] == null) ? null : json['addressDetail'].toString();
    fullName = (json['fullName'] == null) ? null : json['fullName'].toString();
    phone = (json['phone'] == null) ? null : json['phone'].toString();
    isDefault = (json['isDefault'] == null) ? null : json['isDefault'] as bool;
    createdAt = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(user)) data['user'] = user;
    if (!IZIValidate.nullOrEmpty(province?.id)) data['province'] = province?.id;
    if (!IZIValidate.nullOrEmpty(district?.id)) data['district'] = district?.id;
    if (!IZIValidate.nullOrEmpty(village?.id)) data['village'] = village?.id;
    if (!IZIValidate.nullOrEmpty(addressDetail)) data['addressDetail'] = addressDetail;
    if (!IZIValidate.nullOrEmpty(fullName)) data['fullName'] = fullName;
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;
    if (!IZIValidate.nullOrEmpty(isDefault)) data['isDefault'] = isDefault;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
