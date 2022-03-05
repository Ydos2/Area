import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
  }

  void sendDiscord() {
    setState(() {
      ActionsFetch().fetchDiscord(messageController.text,
          "${selectedTime.hour}:${selectedTime.minute}");
    });
  }

  void connectDiscord() {
    setState(() {
      //ActionsFetch().fetchConnectDiscord();
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
        title: const Text('Discord'),
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
                child: const Text("Choose Time"),
              ),
              Text("${selectedTime.hour}:${selectedTime.minute}"),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  sendDiscord();
                  showInSnackBar("Message send !");
                },
                child: const Text('Send message'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(
                              initialUrl:
                                  "https://areachad.herokuapp.com/discord/login?mail=" +
                                      settings.mail_actu,
                              javascriptMode: JavascriptMode.unrestricted,
                            )),
                  );
                  showInSnackBar("Discord is connected !");
                },
                child: const Text('Connect to discord'),
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
