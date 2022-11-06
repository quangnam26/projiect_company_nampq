import 'package:get/get.dart';
import 'package:template/view/screen/recharge/recharge_bingding.dart';
import 'package:template/view/screen/recharge/recharge_page.dart';

class RechargeRouters {
  static const String RECHARGE = '/recharge';

  static List<GetPage> list = [
    GetPage(
      name: RECHARGE,
      page: () => const RechargePage(),
      binding: RechargeBinding()
    ),
  ];
}