import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';

class MailState extends StatefulWidget {
  const MailState({Key? key}) : super(key: key);

  @override
  State<MailState> createState() => StatefulMail();
}

class StatefulMail extends State<MailState> {
  bool _dark = settings.dark_mode;
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController mailController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController objectController = TextEditingController();

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
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

  void setNewNotification(String title, String text) {
    showNotification(1, title, text);
    settings.titles.add(title);
    settings.subtitles.add(text);
    settings.icon.add(Icons.mail);
  }

  void sendEmail() {
    setState(() {
      ActionsFetch().fetchEmail(mailController.text, contentController.text,
          objectController.text, "${selectedTime.hour}:${selectedTime.minute}");
    });
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  showNotification(int id, String title, String text) async {
    var android = const AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(id, title, text, platform,
        payload: 'AndroidCoding.in');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mail',
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: settings.dark_mode ? pf2 : pc3,
      ),
      drawer: NavBar(),
      backgroundColor: settings.dark_mode ? pf1 : pc1,
      body: DefaultTextStyle(
        style: TextStyle(
          color: settings.dark_mode ? pf2 : pc2,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              TextField(
                obscureText: false,
                controller: mailController,
                style: TextStyle(
                  fontFamily: "Raleway",
                  color: settings.dark_mode ? pc1 : pf1,
                ),
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: settings.dark_mode ? pc2 : pc3,
                    ),
                  ),
                  labelText: 'mail',
                  labelStyle: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 19,
                    color: settings.dark_mode ? pc1 : pf1,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              TextField(
                obscureText: false,
                controller: contentController,
                style: TextStyle(
                  fontFamily: "Raleway",
                  color: settings.dark_mode ? pc1 : pf1,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: settings.dark_mode ? pc2 : pc3,
                    ),
                  ),
                  labelText: 'content',
                  labelStyle: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 19,
                    color: settings.dark_mode ? pc1 : pf1,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              TextField(
                obscureText: false,
                controller: objectController,
                style: TextStyle(
                  fontFamily: "Raleway",
                  color: settings.dark_mode ? pc1 : pf1,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: settings.dark_mode ? pc2 : pc3,
                    ),
                  ),
                  labelText: 'object',
                  labelStyle: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 19,
                    color: settings.dark_mode ? pc1 : pf1,
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text("Choose Time",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),),
              ),
              const SizedBox(height: 10.0),
              Text("${selectedTime.hour}:${selectedTime.minute}",
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 18,
            color: settings.dark_mode ? pc3 : pf2,
            fontWeight: FontWeight.w800,
          ),),
              const SizedBox(height: 30.0),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
                ),
                onPressed: () {
                  sendEmail();

                  Future.delayed(const Duration(seconds: 30), () {
                    setNewNotification("Email", "Email send !");
                    setState(() {});
                  });
                  showInSnackBar("Email send !");
                },
                child: const Text('Send Email'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: "Raleway"),
      ),
      backgroundColor: pc5,
      duration: const Duration(seconds: 3),
    ));
  }
}
