import 'package:cricketapp/firebase_options.dart';
import 'package:cricketapp/modules/apptheme/app_theme.dart';
import 'package:cricketapp/routes/app_pages.dart';
import 'package:cricketapp/services/app_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupFlutterNotifications();
  showFlutterNotification(message);
}

late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'cric_now_channel', // id
    'CRICNOW Notifications', // title
    description: 'This channel is used for CRICNOW notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: ['"AE335283BB8C3C2AA776B27369212733']));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await Get.putAsync<AppService>(() => AppService().init());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  FirebaseMessaging.onMessage.listen(showFlutterNotification);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PSL 2024',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      themeMode: ThemeMode.dark,
    );
  }
}
