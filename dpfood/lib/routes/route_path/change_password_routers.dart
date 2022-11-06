import 'package:get/get.dart';
import 'package:template/view/screen/change_password/change_password_binding.dart';
import 'package:template/view/screen/change_password/change_password_page.dart';
// ignore: avoid_classes_with_only_static_members
class ChangePassWordRoutes {
  static const String CHANGEPASS = '/change_pass';
  static List<GetPage> list = [
    GetPage(
      name: CHANGEPASS,
      page: () => ChangePassWordPage(),
      binding: ChangePassWordBinding(),
    ),
  ];
}
