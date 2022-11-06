

import 'package:get/get.dart';
import 'package:template/view/screen/thank_you_screen/thank_you_screen_binding.dart';
import 'package:template/view/screen/thank_you_screen/thank_you_screen_page.dart';

class ThankYouRoutes {
  static const String THANK_YOU = '/thank_you';

  static List<GetPage> list = [
    GetPage(
      name: THANK_YOU,
      page: () => ThankYouPage(),
      binding: ThankYouBinding(),
    ),
  ];
}