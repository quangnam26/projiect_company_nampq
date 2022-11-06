import 'package:get/get.dart';
import 'package:template/view/screen/wallet_money/recharge/recharge_binding.dart';

import 'package:template/view/screen/wallet_money/recharge/recharge_page.dart';
import 'package:template/view/screen/wallet_money/required_recharge/required_recharge_bingding.dart';
import 'package:template/view/screen/wallet_money/required_recharge/required_recharge_page.dart';
import 'package:template/view/screen/wallet_money/wallet_money_binding.dart';
import 'package:template/view/screen/wallet_money/wallet_money_page.dart';

// ignore: avoid_classes_with_only_static_members
class WalletRouters {
  static const String RECHARGE = '/recharge';
  static const String WALLET_MONEY = '/wallet_money';
  static const String REQUIRED_RECHAGE = '/required_rechage';

  static List<GetPage> list = [
    GetPage(
      name: RECHARGE,
      page: () => ReChargePage(),
      binding: ReChargeBinding(),
    ),
    GetPage(
      name: WALLET_MONEY,
      page: () => WalletMoneyPage(),
      binding: WalletMoneyBinding(),
    ),
    GetPage(
      name: REQUIRED_RECHAGE,
      page: () => RequiredRechargePage(),
      binding: RequiredRechargeBinding(),
    )
  ];
}
