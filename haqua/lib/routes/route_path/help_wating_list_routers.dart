



import 'package:get/get.dart';
import 'package:template/view/screen/help_wating_list/help_wating_list_binding.dart';
import 'package:template/view/screen/help_wating_list/help_wating_list_page.dart';

class HelpWatingListRoutes {
  static const String HELP_WATING_LIST = '/help_wating_list';

  static List<GetPage> list = [
    GetPage(
      name: HELP_WATING_LIST,
      page: () => HelpWatingListPage(),
      binding: HelpWatingListBinding(),
    ),
  ];
}