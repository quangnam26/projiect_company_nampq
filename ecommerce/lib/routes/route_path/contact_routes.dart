// ignore: file_names
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/contact/contact_page.dart';
import '../../view/screen/accounts/contact/contact_binhgding.dart';

// ignore: avoid_classes_with_only_static_members
class ContactRoutes {
  static const String CONTACT = '/contact';

  static List<GetPage> list = [
    GetPage(
      name: CONTACT,
      page: () => ContactPage(),
      binding: ContactBingding(),
    ),
  ];
}
