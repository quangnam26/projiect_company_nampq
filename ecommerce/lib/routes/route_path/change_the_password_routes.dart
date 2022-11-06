
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/change_the_password/change_the_password_bingding.dart';
import 'package:template/view/screen/accounts/change_the_password/change_the_password_page.dart';


// ignore: avoid_classes_with_only_static_members
class ChangeThePassWordRoutes {
  static const String CHANGE_THE_PASSWORD = '/change_the_password';

  static List<GetPage> list = [
    GetPage(
      name: CHANGE_THE_PASSWORD,
      page: () => ChangeThePassWordPage(),
      binding: ChangeThePassWordBingding(),
    ),
  ];
}
