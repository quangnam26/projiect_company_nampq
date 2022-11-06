

import 'package:get/get.dart';
import 'package:template/view/screen/areas_of_expertise/areas_of_expertise_binding.dart';
import 'package:template/view/screen/areas_of_expertise/areas_of_expertise_page.dart';

class AreasOfExpertiseRoutes {
  static const String AREAS_OF_EXPERTISE = '/areas_of_expertise';

  static List<GetPage> list = [
    GetPage(
      name: AREAS_OF_EXPERTISE,
      page: () => AreasOfExpertisePage(),
      binding: AreasOfExpertiseBinding(),
    ),
  ];
}
