
import 'package:get/get.dart';
import 'package:template/view/screen/ready_screen/ready_screen_binding.dart';
import 'package:template/view/screen/ready_screen/ready_screen_page.dart';

class ReadyScreenRoutes {
  static const String READY_SCREEN = '/ready_screen';

  static List<GetPage> list = [
    GetPage(
      name: READY_SCREEN,
      page: () => ReadyScreenPage(),
      binding: ReadyScreenBinding(),
    ),
  ];
}
