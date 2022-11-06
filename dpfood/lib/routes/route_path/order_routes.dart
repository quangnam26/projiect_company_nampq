import 'package:get/get.dart';

import '../../view/screen/adress/address_binding.dart';
import '../../view/screen/adress/address_page.dart';
import '../../view/screen/adress/edit_address/edit_address_binding.dart';
import '../../view/screen/adress/edit_address/edit_address_page.dart';
import '../../view/screen/coupons/coupons_binding.dart';
import '../../view/screen/coupons/coupons_page.dart';
import '../../view/screen/orders/order_page.dart';
import '../../view/screen/orders/order_binding.dart';
import '../../view/screen/status_order/status_order_binding.dart';
import '../../view/screen/status_order/status_order_page.dart';




// ignore: avoid_classes_with_only_static_members
class OrderRoutes {
  static const String ORDER = '/order';
  static const String COUPONS = '/coupons';
  static const String STATUS_ORDER = '/status_order';
  static const String ADDRESS_ORDER = '/address_order';
  static const String EDIT_ADDRESS_ORDER = '/edit_address';


  static List<GetPage> list = [
    GetPage(
      name: ORDER,
      page: () => OrderPage(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: COUPONS,
      page: () => CouponsPage(),
      binding: CouponsBinding(),
    ),
    GetPage(
      name: STATUS_ORDER,
      page: () => StatusOrderPage(),
      binding: StatusOrderBinding(),
    ),
    GetPage(
      name: ADDRESS_ORDER,
      page: () => AddressPage(),
      binding: AddressBinding(),
    ),

    GetPage(
      name: EDIT_ADDRESS_ORDER,
      page: () => EditAddressPage(),
      binding: EditAddressBinding(),
    ),

    
  ];
}
