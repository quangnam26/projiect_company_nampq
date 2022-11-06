import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

import '../answer_quiz/answer_quiz_response.dart';

class QuizResponse {
  String? id;
  String? idCertificate;
  String? typeQuestion;
  String? textQuestion;
  String? imageQuestion;
  String? audioQuestion;
  String? videoQuestion;
  List<AnswerQuizResponse>? answers;
  DateTime? createdAt;
  DateTime? updatedAt;

  QuizResponse({this.id, this.idCertificate, this.typeQuestion, this.textQuestion, this.imageQuestion, this.audioQuestion, this.videoQuestion, this.answers, this.createdAt, this.updatedAt,});

  ///
  /// From JSON
  ///

  QuizResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    idCertificate = !IZIValidate.nullOrEmpty(json['idCertificate']) ? json['idCertificate'].toString() : null;
    typeQuestion = !IZIValidate.nullOrEmpty(json['typeQuestion']) ? json['typeQuestion'].toString() : null;
    textQuestion = !IZIValidate.nullOrEmpty(json['textQuestion']) ? json['textQuestion'].toString() : null;
    imageQuestion = !IZIValidate.nullOrEmpty(json['imageQuestion']) ? json['imageQuestion'].toString() : null;
    audioQuestion = !IZIValidate.nullOrEmpty(json['audioQuestion']) ? json['audioQuestion'].toString() : null;
    videoQuestion = !IZIValidate.nullOrEmpty(json['videoQuestion']) ? json['videoQuestion'].toString() : null;
    if (json['answers'] != null && json['answers'].toString().length != 24) {
      answers = (json['answers'] as List<dynamic>).map((e) => AnswerQuizResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      answers = null;
    }
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idCertificate)) data['idCertificate'] = idCertificate;
    if (!IZIValidate.nullOrEmpty(typeQuestion)) data['typeQuestion'] = typeQuestion;
    if (!IZIValidate.nullOrEmpty(imageQuestion)) data['imageQuestion'] = imageQuestion;
    if (!IZIValidate.nullOrEmpty(audioQuestion)) data['audioQuestion'] = typeQuestion;
    if (!IZIValidate.nullOrEmpty(videoQuestion)) data['videoQuestion'] = videoQuestion;
    if (!IZIValidate.nullOrEmpty(answers)) data['answers'] = answers;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedat'] = updatedAt;
    return data;
  }

  @override
  String toString() => 'QuizResponse(id: $id, idCertificate: $idCertificate,typeQuestion:$typeQuestion,textQuestion:$textQuestion,imageQuestion:$imageQuestion,audioQuestion:$audioQuestion,videoQuestion:$videoQuestion,answers:$answers,createdAt:$createdAt,updatedAt:$updatedAt)';
}
