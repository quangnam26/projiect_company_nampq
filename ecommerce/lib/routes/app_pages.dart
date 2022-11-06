import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/change_the_password_routes.dart';
import 'package:template/routes/route_path/contact_routes.dart';
import 'package:template/routes/route_path/exchange_policy_routes.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/cart_router.dart';
import 'package:template/routes/route_path/category_routes.dart';
import 'package:template/routes/route_path/chat_routes.dart';

import 'package:template/routes/route_path/detail_page_router.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/routes/route_path/order_router.dart';
import 'package:template/routes/route_path/other_policies_routes.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:template/routes/route_path/hunting_vouchers_routes.dart';
import 'package:template/routes/route_path/news%20routes.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';
import 'package:template/routes/route_path/search_results_routes.dart';
import 'package:template/routes/route_path/shipping_method_routes.dart';

import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/routes/route_path/wallet_routes.dart';
// import 'package:template/routes/route_path/wallet_money_routers.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    ...SplashRoutes.list,
    ...AccountRoutes.list,
    ...ChangeThePassWordRoutes.list,
    ...OtherPoliciesRoutes.list,
    ...ExchangePolicyRoutes.list,
    ...ContactRoutes.list,
    ...NewsRouters.list,
    ...HuntingVouchersRoutes.list,
    ...PaymentmethodsRoutes.list,
    ...HomeRoutes.list,
    ...CartRoutes.list,
    ...ShippingMethodRoutes.list,
    ...HomeRoutes.list,
    ...CartRoutes.list,
    ...DetailPageRoutes.list,
    ...CategoryRoutes.list,
    ...SearchResultsRoutes.list,
    ...NotificationRoutes.list,
    ...ChatRoutes.list,
    ...WalletRouters.list,
    ...OrderRoutes.list
  ];
}
