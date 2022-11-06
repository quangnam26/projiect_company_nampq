import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/onboarding/onboarding_page.dart';
import 'package:template/view/screen/splash/splash_binding.dart';
import 'package:template/view/screen/splash/splash_page.dart';
import '../../view/screen/home/home_binding.dart';
import '../../view/screen/home/home_page.dart';
import '../../view/screen/onboarding/onboarding_binding.dart';

// ignore: avoid_classes_with_only_static_members
class SplashRoutes {
  static const String SPLASH = '/splash';
  static const String ON_BOARDING = '/onboarding';
  static const String STATE = '/state';
  static const String VEHICLE = '/vehicle';
  static const String HOME = '/home';

    


  static List<GetPage> list = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    
    // GetPage(
    //   name: HOME,
    //   page: () => DashBoardPage(),
    //   binding: DashBoardBinding(),
    // ),

    
    GetPage(
      name: HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: ON_BOARDING,
      page: () => OnboardingPage(),
      binding: OnboardingBinding(),
    ),
  ];
}
