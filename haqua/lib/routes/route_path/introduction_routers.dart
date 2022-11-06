import 'package:get/get.dart';
import 'package:template/view/screen/introduction/introduction_binding.dart';
import 'package:template/view/screen/introduction/introduction_page.dart';

class IntroductionRoutes {
  static const String INTRODUCTION = '/introduction';

  static List<GetPage> list = [
    GetPage(
      name: INTRODUCTION,
      page: () => IntroductionPage(),
      binding: IntroductionBinding(),
    ),
  ];
}
