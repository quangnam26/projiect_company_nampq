import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:template/app_binding.dart';
import 'package:template/data/datasource/remote/dio/izi_socket.dart';
import 'package:template/di_container.dart';
import 'package:template/localization/app_localization.dart';
import 'package:template/multiple_language/locale_string.dart';
import 'package:template/routes/app_pages.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/theme/app_theme.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/firebase_notification/firebase_options.dart';
import 'package:template/utils/firebase_notification/firebase_service.dart';
import 'package:template/utils/firebase_notification/local_notification_service.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'di_container.dart' as di;

/// Initialize FirebaseMessaging.
FirebaseMessaging messaging = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Set preferred Orientation.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Init dependence injection.
  await di.init();

  /// Set locale message.
  timeago.setLocaleMessages('vi', timeago.ViMessages());

  /// Initialize background service.
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();

  /// Setup FCM notification.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  await FcmService().initForegroundNotification();
  await LocalNotificationService().init();
  await FcmService().init();

  /// Get DeviceToken IOS or Android.
  if (Platform.isAndroid) {
    final token = await messaging.getToken();
    print("Token Device $token");
    sl<SharedPreferenceHelper>().setTokenDevice(token.toString());
  } else if (Platform.isIOS) {
    final token = await messaging.getAPNSToken();
    sl<SharedPreferenceHelper>().setTokenDevice(token.toString());
  }

  /// Instance Easy Loading.
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 1500)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..progressColor = ColorResources.WHITE
    ..backgroundColor = ColorResources.BOTTOM_BAR_DASHBOAD
    ..indicatorColor = ColorResources.WHITE
    ..textColor = ColorResources.WHITE
    ..maskColor = Colors.transparent
    ..userInteractions = true
    ..dismissOnTap = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    if (kReleaseMode) exit(1);
  };
  runApp(
    const MyApp(),
  );
}

///
/// Initialize background service.
///
Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      /// This will be executed when app is in foreground or background in separated isolate.
      onStart: onStart,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      /// This will be executed when app is in foreground in separated isolate.
      onForeground: onStart,

      /// You have to enable background fetch capability on xcode project.
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

/// To ensure this is executed.
/// Run app from xcode, then from xcode menu, select Simulate Background Fetch.
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

///
/// On start background service.
///
Future<void> onStart(ServiceInstance service) async {
  /// Only available for flutter 3.0.0 and later.
  DartPluginRegistrant.ensureInitialized();

  /// For flutter prior to version 3.0.0.
  /// We have to register the plugin manually.

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.setForegroundNotificationInfo(
      title: "HaQua",
      content: "Running...",
    );
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  if (!IZISocket().socket.hasListeners('call_socket')) {
    IZISocket().socket.on(
      'call_socket',
      (data) {
        print('Call_socket');
        //TODO: Implement call socket
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: SplashRoutes.SPLASH,
      initialBinding: AppBinding(),
      translations: LocaleString(),
      locale: Locale(sl<SharedPreferenceHelper>().getLanguage),
      getPages: AppPages.list,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      builder: EasyLoading.init(
        builder: (context, widget) {
          return MediaQuery(
            ///Setting font does not change with system font size
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}
