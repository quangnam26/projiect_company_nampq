import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/dash_board/dash_board_binding.dart';
import 'package:template/view/screen/dash_board/dash_board_page.dart';
import 'package:template/view/screen/no_internet_screen/no_internet_screen_binding.dart';
import 'package:template/view/screen/no_internet_screen/no_internet_screen_page.dart';

// ignore: avoid_classes_with_only_static_members
class HomeRoutes {
  static const String DASHBOARD = '/dashboard';
  static const String NO_INTERNET = '/no_internet';

  static List<GetPage> list = [
    GetPage(
      name: DASHBOARD,
      page: () => DashBoardPage(),
      binding: DashBoardBinding(),
    ),
    GetPage(
      name: NO_INTERNET,
      page: () => NoInternetPage(),
      binding: NoInternetBinding(),
    ),
  ];
}
