import 'package:get/get.dart';

import 'package:template/view/screen/shippingmethod/shipping_method_page.dart';

import '../../view/screen/shippingmethod/shipping_method_bingding.dart';

// ignore: avoid_classes_with_only_static_members
class ShippingMethodRoutes {
  static const String SHIPPING_METHOD = '/shipping_method';


  static List<GetPage> list = [
    GetPage(
      name: SHIPPING_METHOD,
      page: () => ShipperMethodPage(),
      binding: ShipperMethodBingding(),
    ),

  ];
}
