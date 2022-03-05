import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mail',
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),),
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
                  sendEmail();
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
