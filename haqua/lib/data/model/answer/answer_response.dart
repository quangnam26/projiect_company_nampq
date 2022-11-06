import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class AnswerResponse {
  String? id;
  UserResponse? idUser;
  String? idUserString;
  int? price;
  String? statusSelect;
  AnswerResponse({
    this.idUser,
    this.price,
    this.statusSelect,
  });

  ///
  /// From JSON
  ///
  AnswerResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    idUserString = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
    if (json['idUser'] != null && json['idUser'].toString().length != 24) {
      idUser = UserResponse.fromJson(json['idUser'] as Map<String, dynamic>);
    }
    price = !IZIValidate.nullOrEmpty(json['price']) ? IZINumber.parseInt(json['price'].toString()) : null;
    statusSelect = !IZIValidate.nullOrEmpty(json['statusSelect']) ? json['statusSelect'].toString() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idUserString)) data['idUser'] = idUserString;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;
    if (!IZIValidate.nullOrEmpty(statusSelect)) data['statusSelect'] = statusSelect;

    return data;
  }

  @override
  String toString() {
    return 'AnswerResponse(id: $id, idUser: $idUser, idUserString: $idUserString, price: $price, statusSelect: $statusSelect)';
  }
}
