import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';
import 'package:area/components/ActionsFetch.dart';
import 'package:area/components/Oauth2.dart';

class DiscordState extends StatefulWidget {
  const DiscordState({Key? key}) : super(key: key);

  @override
  State<DiscordState> createState() => StatefulDiscord();
}

class StatefulDiscord extends State<DiscordState> {
  bool _dark = settings.dark_mode;
  TimeOfDay selectedTime = TimeOfDay.now();

  TextEditingController messageController = TextEditingController();

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
    showNotification(0, title, text);
    settings.titles.add(title);
    settings.subtitles.add(text);
    settings.icon.add(Icons.discord);
  }

  void sendDiscord() {
    setState(() {
      ActionsFetch().fetchDiscord(messageController.text,
          "${selectedTime.hour}:${selectedTime.minute}");
    });
  }

  void sendDiscordBot() {
    setState(() {
      ActionsFetch().fetchDiscordBot();
    });
  }

  showNotification(int id, String title, String text) async {
    var android = const AndroidNotificationDetails('channel id', 'channel NAME',
        priority: Priority.high, importance: Importance.max);
    var iOS = const IOSNotificationDetails();
    var platform = NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(id, title, text, platform,
        payload: 'AndroidCoding.in');
  }

  void connectDiscord() {
    setState(() {
      oauthTest();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Discord',
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
                controller: messageController,
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
                  labelText: 'message',
                  labelStyle: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 19,
                    color: settings.dark_mode ? pc1 : pf1,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectTime(context);
                },
                child: const Text(
                  "Choose Time",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                "${selectedTime.hour}:${selectedTime.minute}",
                style: TextStyle(
                  fontFamily: "Raleway",
                  fontSize: 18,
                  color: settings.dark_mode ? pc3 : pf2,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  sendDiscord();

                  Future.delayed(const Duration(seconds: 30), () {
                    setNewNotification("Discord", "Message send !");
                    setState(() {});
                  });
                },
                child: const Text(
                  'Send message',
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  sendDiscordBot();

                  Future.delayed(const Duration(seconds: 30), () {
                    setState(() {});
                  });
                },
                child: const Text(
                  'Tests your discord bot',
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              ScreenTypeLayout(
                  mobile: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _launchInBrowser(
                          "https://areachad.herokuapp.com/discord/login?mail=" +
                              settings.mail_actu);
                      showInSnackBar("Discord is connected !");
                    },
                    child: const Text(
                      'Connect to discord',
                      style: TextStyle(
                        fontFamily: "Raleway",
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  desktop: TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      _launchInBrowser(
                          "https://areachad.herokuapp.com/discord/login?mail=" +
                              settings.mail_actu);
                      showInSnackBar("Discord is connected !");
                    },
                    child: const Text('Connect to discord'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    )) {
      throw 'Could not launch $url';
    }
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
