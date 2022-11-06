import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/splash/splash_binding.dart';
import 'package:template/view/screen/splash/splash_page.dart';

class SplashRoutes {
  static const String SPLASH = '/splash';
  static const String STATE = '/state';
  static const String VEHICLE = '/vehicle';

  static List<GetPage> list = [
    GetPage(
      name: SPLASH,
      page:()=> SplashPage(),
      binding: SplashBinding(),
    ), 
  ];
}




