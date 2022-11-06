import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app_binding.dart';
import 'package:template/firebase_options.dart';
import 'package:template/routes/app_pages.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/firebase_service.dart';
import 'package:template/utils/internet_connection.dart';
import 'package:template/utils/local_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'di_container.dart' as di;
import 'theme/app_theme.dart';

Rx<CONNECTION_STATUS> connectionStatus = CONNECTION_STATUS.CONNECTED.obs;



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  await FcmService().initForegroundNotification();

  timeago.setLocaleMessages('vi', timeago.ViMessages());
  await LocalNotificationService().init();
  await FcmService().init();
  // await FcmService().backgroundHandler();
  print("Device token: ${await FirebaseMessaging.instance.getToken()}");
    //authRequest.fcmToken = Platform.isIOS ? await firebase.getAPNSToken() : await firebase.getToken();
  
  

  
  await di.init();

  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = ColorResources.PRIMARY_1
    ..backgroundColor = Colors.white
    ..indicatorColor = ColorResources.PRIMARY_1
    ..textColor = ColorResources.PRIMARY_1
    ..maskColor = Colors.transparent
    ..userInteractions = true
    ..dismissOnTap = false;
  checkConnection();
  runApp(const MyApp());
}

void checkConnection() {
  final connection = GetIt.I<InternetConnection>();
  connection.setConnectionChecker(
    status: connectionStatus,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: SplashRoutes.SPLASH,
      initialBinding: AppBinding(),
      defaultTransition: Transition.cupertino,
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('vi','VN'),
      supportedLocales: const [
        Locale('vi','VN')
      ],
      //localeResolutionCallback: (locale, supportedLocales) => app_constants.localeResolutionCallback(locale!, supportedLocales),
      localizationsDelegates: localizationsDelegates,
      builder: EasyLoading.init(),
      //theme: ThemeData(),
      //darkTheme: ThemeData.dark(),
      //themeMode: settingsController.themeMode,
    );
  }
}
