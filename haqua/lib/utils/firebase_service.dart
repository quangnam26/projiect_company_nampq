// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:template/notification/my_notification.dart';

// class FirebaseService {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();

//   FirebaseService(){
//     init();
//   }

//   Future<void> init() async {
//     // init firebase
//     Firebase.initializeApp().then((value) => {

//     });

//     // init notification
//     await MyNotification.initialize(flutterLocalNotificationsPlugin);

//     // init firebase FCM run on background
//     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
//   }
// }
