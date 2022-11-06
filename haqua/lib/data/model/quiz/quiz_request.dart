import 'package:template/data/model/quiz/quiz_response.dart';

class QuizRequest extends QuizResponse {
  QuizRequest();
  QuizRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
