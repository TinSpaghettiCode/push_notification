import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notification/api/firebase_api.dart';
import 'package:push_notification/page/home_screen.dart';
import 'package:push_notification/page/notification_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission for android
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    provisional: false,
  );

  // Handle foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Push Notification',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 40),
          ),
        ),
        navigatorKey: navigatorKey,
        home: const HomeScreen(),
        routes: {
          NotificationScreen.route: (context) => const NotificationScreen(),
        },
      );
}
