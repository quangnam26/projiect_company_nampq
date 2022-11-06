import 'package:template/data/model/answer/answer_response.dart';
import 'package:template/helper/izi_validate.dart';

class AnswerRequest extends AnswerResponse {
  String? idUserRequest;
  AnswerRequest({
    this.idUserRequest,
  });

  ///
  ///fromJson
  ///
  @override
  AnswerRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
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
