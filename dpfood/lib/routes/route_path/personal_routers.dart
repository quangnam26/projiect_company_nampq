import 'package:get/get.dart';
import 'package:template/view/screen/personal/detail/detail_personal_binding.dart';
import 'package:template/view/screen/personal/detail/detail_personal_page.dart';
import 'package:template/view/screen/personal/personal_biding.dart';
import 'package:template/view/screen/personal/personal_page.dart';

// ignore: avoid_classes_with_only_static_members
class PersonalRoutes {
  static const String PERSONAL = '/personal';
  static const String DETAILPERSONAL = '/detailPersonal';
  static List<GetPage> list = [
    GetPage(
        name: PERSONAL, page: () => PersonalPage(), binding: PersonalBinding()),
    GetPage(
        name: DETAILPERSONAL,
        page: () => DetailPersonalPage(),
        binding: DetailPersonalBinding()),
  ];
}
