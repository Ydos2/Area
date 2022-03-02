import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotifState extends StatefulWidget {
  const NotifState({Key? key}) : super(key: key);

  @override
  State<NotifState> createState() => StatefulNotif();
}

class StatefulNotif extends State<NotifState> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('app_icon');
    var iOS = const IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  void onSelectNotification(String? payload) {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Notification'),
        content: Text('$payload'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Local Notification'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: showNotification,
          child: Text(
            'Tap To Get a Notification',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }

  showNotification() async {
    var android = const AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'New Tutorial', 'Local Notification', platform,
        payload: 'AndroidCoding.in');
  }
}
