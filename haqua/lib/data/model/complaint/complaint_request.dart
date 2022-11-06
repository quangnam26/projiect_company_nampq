import 'package:template/data/model/complaint/complaint_response.dart';
import 'package:template/helper/izi_validate.dart';

class ComplaintRequest extends ComplaintResponse {
  String? idUserRequest;
  ComplaintRequest({
    this.idUserRequest,
  });

  ///
  ///fromJson
  ///
  @override
  ComplaintRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idUserRequest = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
  }

  ///
  ///toJson
  ///
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idUserRequest)) data['idUser'] = idUserRequest;
    return data;
  }
}
