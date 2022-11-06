// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
part 'voucher_response.g.dart';

@HiveType(typeId: 22)
class VoucherResponse {
  @HiveField(0)
  String? id;
  @HiveField(1)
  CategoryResponse? idCategory;
  @HiveField(2)
  UserResponse? idUserShop;
  @HiveField(3)
  double? minOrderPrice;
  @HiveField(4)
  double? discountMoney;
  @HiveField(5)
  int? fromDate;
  @HiveField(6)
  int? toDate;
  @HiveField(7)
  bool? isEnable;
  @HiveField(8)
  String? name;
  @HiveField(9)
  String? code;
  @HiveField(10)
  String? image;
  @HiveField(11)
  int? limit;
  @HiveField(12)
  List<String>? voucherOfUser;
  @HiveField(13)
  int? voucherType;
  @HiveField(14)
  List<String>? userUsed;
  VoucherResponse({
    this.id,
    this.idCategory,
    this.idUserShop,
    this.minOrderPrice,
    this.discountMoney,
    this.fromDate,
    this.toDate,
    this.isEnable,
    this.name,
    this.code,
    this.image,
    this.voucherOfUser,
    this.voucherType,
    this.userUsed,
  });

  VoucherResponse.fromJson(Map<String, dynamic> json) {
    id = (json['id'] == null) ? null : json['_id'] as String;
    idCategory = (json['idCategory'] == null) ? null : CategoryResponse.fromJson(json['idCategory'] as Map<String, dynamic>);
    idUserShop = (json['idUserShop'] == null) ? null : UserResponse.fromMap(json['idUserShop'] as Map<String, dynamic>);
    minOrderPrice = (json['minOrderPrice'] == null) ? null : IZINumber.parseDouble(json['minOrderPrice']);
    discountMoney = (json['discountMoney'] == null) ? null : IZINumber.parseDouble(json['discountMoney']);
    fromDate = (json['fromDate'] == null) ? null : IZINumber.parseInt(json['fromDate']);
    toDate = (json['toDate'] == null) ? null : IZINumber.parseInt(json['toDate']);
    isEnable = (json['isEnable'] == null) ? null : json['isEnable'] as bool;
    name = (json['name'] == null) ? null : json['name'].toString();
    code = (json['code'] == null) ? null : json['code'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    voucherOfUser = (json['voucherOfUser'] == null) ? null : (json['voucherOfUser'] as List<dynamic>).map((e) => e.toString()).toList();
    voucherType = (json['voucherType'] == null) ? null : IZINumber.parseInt(json['voucherType']);
    userUsed = (json['userUsed'] == null) ? null : (json['userUsed'] as List<dynamic>).map((e) => e.toString()).toList();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['id'] = id;
    if (!IZIValidate.nullOrEmpty(idCategory)) data['idCategory'] = idCategory;
    if (!IZIValidate.nullOrEmpty(idUserShop)) data['idUserShop'] = idUserShop;
    if (!IZIValidate.nullOrEmpty(minOrderPrice)) data['minOrderPrice'] = minOrderPrice;
    if (!IZIValidate.nullOrEmpty(discountMoney)) data['discountMoney'] = discountMoney;
    if (!IZIValidate.nullOrEmpty(fromDate)) data['fromDate'] = fromDate;
    if (!IZIValidate.nullOrEmpty(toDate)) data['toDate'] = toDate;
    if (!IZIValidate.nullOrEmpty(isEnable)) data['isEnable'] = isEnable;
    if (!IZIValidate.nullOrEmpty(name)) data['name'] = name;
    if (!IZIValidate.nullOrEmpty(code)) data['code'] = code;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    return data;
  }

}
