import 'package:get/get.dart';
import 'package:template/view/screen/huntingvouchers/hunting_vouchers_bingding.dart';

import '../../view/screen/huntingvouchers/hunting_vouchers_page.dart';

// ignore: avoid_classes_with_only_static_members
class HuntingVouchersRoutes {
  static const String HUNTING_VOUCHERS = '/hunting_vouchers';

  static List<GetPage> list = [
    GetPage(
      name: HUNTING_VOUCHERS,
      page: () => HuntingVoucherPage(),
      binding: HuntingVouchersBingding(),
    ),
  ];
}
