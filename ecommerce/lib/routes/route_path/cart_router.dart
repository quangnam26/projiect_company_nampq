import 'package:get/get.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_binding.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_page.dart';
import 'package:template/view/screen/cart/address_delivery/editaddress/edit_address_binding.dart';
import 'package:template/view/screen/cart/address_delivery/editaddress/edit_address_page.dart';
import 'package:template/view/screen/cart/cart_binding.dart';
import 'package:template/view/screen/cart/cart_page.dart';
import 'package:template/view/screen/cart/choosevoucher/choose_voucher_bingding.dart';
import 'package:template/view/screen/cart/choosevoucher/choose_voucher_page.dart';
import 'package:template/view/screen/cart/payment/payment_binding.dart';
import 'package:template/view/screen/cart/payment/payment_page.dart';

// ignore: avoid_classes_with_only_static_members
class CartRoutes {
  static const String CART = '/cart';
  static const String PAYMENT = '/payment';
  static const String ADDRESS_DELIVERY = '/address_delivery';
  static const String EDIT_ADDRESS = '/edit_address';
    static const String CHOOSE_VOUCHER = '/choose_voucher';

  static List<GetPage> list = [
    GetPage(
      name: CART,
      page: () => CartPage(),
      binding: CartBinding(),
    ),
    GetPage(
      name: PAYMENT,
      page: () => PaymentPage(),
      binding: PaymentBinding(),
    ),
     GetPage(
      name: ADDRESS_DELIVERY,
      page: () => AddressDeliveryPage(),
      binding: AddressDeliveryBinding(),
    ),
    GetPage(
      name: EDIT_ADDRESS,
      page: () => EditAddessPage(),
      binding: EditAddressBingDing(),
    ),
        GetPage(
      name: CHOOSE_VOUCHER,
      page: () => ChooseVoucherPage(),
      binding: ChooseVoucherBingding(),
    )
  ];
}
