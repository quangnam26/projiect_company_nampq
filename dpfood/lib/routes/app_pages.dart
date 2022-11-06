import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/change_password_routers.dart';
import 'package:template/routes/route_path/history_order.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/routes/route_path/otp_page_router.dart';
import 'package:template/routes/route_path/personal_routers.dart';
import 'package:template/routes/route_path/order_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/routes/route_path/wallet_money_routers.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    ...SplashRoutes.list,
    ...NotificationRoutes.list,
    ...OTPPageRoutes.list,
    ...PersonalRoutes.list,
    ...HistoryOrderRoutes.list,
    ...WalletMoneyRoutes.list,
    ...ChangePassWordRoutes.list,

    ...AuthRoutes.list,
    ...AccountRoutes.list,
    ...HomeRoutes.list,
    ...OrderRoutes.list,
  ];
}
