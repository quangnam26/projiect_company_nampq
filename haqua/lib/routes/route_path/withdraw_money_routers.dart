import 'package:get/get.dart';
import 'package:template/view/screen/withdrawmoney.dart/withdraw_money_bingding.dart';
import 'package:template/view/screen/withdrawmoney.dart/withdraw_money_page.dart';

class WithDrawMoneyRouters {
  static const String WITH_DRAW_MONEY = '/with_draw_money';

  static List<GetPage> list = [
    GetPage(
      name: WITH_DRAW_MONEY,
      page: () => WithDrawMoneyPage(),
      binding: WithDrawMoneyBingding(),
    ),
  ];
}
