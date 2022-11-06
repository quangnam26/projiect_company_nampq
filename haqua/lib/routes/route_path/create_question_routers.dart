import 'package:get/get.dart';
import 'package:template/view/screen/create_question/ask_and_answer/ask_and_answer_binding.dart';
import 'package:template/view/screen/create_question/ask_and_answer/ask_and_answer_page.dart';
import 'package:template/view/screen/create_question/create_question_binding.dart';
import 'package:template/view/screen/create_question/create_question_page.dart';

class CreateQuestionRoutes {
  static const String CREATE_QUESTION = '/create_question';
  static const String ASK_AND_ANSWER = '/ask_and_answer';

  static List<GetPage> list = [
    GetPage(
      name: CREATE_QUESTION,
      page: () => CreateQuestionPage(),
      binding: CreateQuestionBinding(),
    ),
    GetPage(
      name: ASK_AND_ANSWER,
      page: () => AskAndAnswerPage(),
      binding: AskAndAnswerBinding(),
    ),
  ];
}
