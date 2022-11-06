import 'package:template/data/model/question/question_response.dart';
import 'package:template/helper/izi_validate.dart';

class QuestionRequest extends QuestionResponse {
  String? idUserRequest;
  String? idSubSpecializeRequest;
  int? price;
  QuestionRequest({
    this.idUserRequest,
    this.idSubSpecializeRequest,
    this.price,
  });

  ///
  ///fromJson
  ///
  @override
  QuestionRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    idUserRequest = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
    idSubSpecializeRequest = !IZIValidate.nullOrEmpty(json['idSubSpecialize']) ? json['idSubSpecialize'].toString() : null;
  }

  ///
  ///toJson
  ///
  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idUserRequest)) data['idUser'] = idUserRequest;
    if (!IZIValidate.nullOrEmpty(idSubSpecializeRequest)) data['idSubSpecialize'] = idSubSpecializeRequest;
    if (!IZIValidate.nullOrEmpty(price)) data['price'] = price;
    return data;
  }

  // @override
  // String toString() => 'QuestionRequest(idUserRequest: $idUserRequest, idSubSpecializeRequest: $idSubSpecializeRequest)';
}
