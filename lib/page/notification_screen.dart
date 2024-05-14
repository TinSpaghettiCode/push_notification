import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notifications'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${(message as dynamic).notification?.title ?? 'No title'}'),
            Text('${(message as dynamic).notification?.body ?? 'No body'}'),
            Text('${(message as dynamic).data ?? 'No data'}')
          ],
        ),
      ),
    );
  }
}
