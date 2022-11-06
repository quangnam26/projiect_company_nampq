import 'package:get/get.dart';
import 'package:template/view/screen/wallet/recharge_money/recharge_money_bingding.dart';
import 'package:template/view/screen/wallet/required_recharge.dart/required_recharge_bingding.dart';
import 'package:template/view/screen/wallet/required_recharge.dart/required_recharge_page.dart';
import 'package:template/view/screen/wallet/with_draw_money/withdraw_money_bingding.dart';
import 'package:template/view/screen/wallet/with_draw_money/withdraw_money_page.dart';
import '../../view/screen/wallet/recharge_money/recharge_money_page.dart';
import '../../view/screen/wallet/wallet_money_binding.dart';
import '../../view/screen/wallet/wallet_money_page.dart';

// ignore: avoid_classes_with_only_static_members
class WalletMoneyRoutes {
  static const String WALLETMONEY = '/wallet_money';
  static const String RECHARGE = '/recharge';
  static const String WITHDRAW = '/withdraw';
  static const String REQUIRED_RECHARGE = '/requried_recharge';
  static List<GetPage> list = [
    GetPage(
      name: WALLETMONEY,
      page: () => V2WalletMoneyPage(),
      binding: V2WalletMoneyBinding(),
      // page: () => WalletMoneyPage(),
      // binding: WalletMoneyBinding(),
    ),
    GetPage(
      name: RECHARGE,
      page: () => RechargeMoneyPage(),
      binding: RechargeMoneyBinding(),
      // page: () => ReChargePage(),
      // binding: ReChargeBinding(),
    ),
    GetPage(
      name: REQUIRED_RECHARGE,
      page: () => RequiredRechargePage(),
      binding: RequiredRechargeBinding(),
      // page: () => ReChargePage(),
      // binding: ReChargeBinding(),
    ),
    GetPage(
      name: WITHDRAW,
      page: () => WithDrawMoneyPage(),
      binding: WithDrawMoneyBinding(),
      // page: () => ReChargePage(),
      // binding: ReChargeBinding(),
    ),
  ];
}
