import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/routes/route_path/account_routes.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/splash_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static List<GetPage> list = [
    ...SplashRoutes.list,
    ...AuthRoutes.list,
    ...AccountRoutes.list,
  ];
}
