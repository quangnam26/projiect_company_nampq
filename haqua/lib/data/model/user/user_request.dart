import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class UserRequest extends UserResponse {
  int? money;
  int? bornRequest;
  String? idProvinceRequest;

  UserRequest({
    this.money,
    this.bornRequest,
    this.idProvinceRequest,
  });

  @override
  UserRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    bornRequest = !IZIValidate.nullOrEmpty(json['born']) ? int.parse(json['born'].toString()) : null;
    money = !IZIValidate.nullOrEmpty(json['money']) ? IZINumber.parseInt(json['money'].toString()) : null;
    idProvinceRequest = !IZIValidate.nullOrEmpty(json['idProvince']) ? json['idProvince'].toString() : null;
  }

  ///
  ///toJson
  ///
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();

    if (!IZIValidate.nullOrEmpty(money)) data['money'] = money;
    if (!IZIValidate.nullOrEmpty(idProvinceRequest)) data['idProvince'] = idProvinceRequest;
    if (!IZIValidate.nullOrEmpty(bornRequest) && bornRequest != 0) data['born'] = bornRequest;

    return data;
  }
}
