import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20exchangepolicy/%20exchange_policy_bingding.dart';
import '../../view/screen/accounts/otherpolicies/ exchangepolicy/ exchange_policy_page.dart';

// ignore: avoid_classes_with_only_static_members
class ExchangePolicyRoutes {
  static const String PURCHASE_POLICY = '/purchase_policy';
  static List<GetPage> list = [
    GetPage(
      name: PURCHASE_POLICY,
      page: () => ExchangePolicyPage(),
      binding: ExchangePolicyBingding(),
    )
  ];
}
