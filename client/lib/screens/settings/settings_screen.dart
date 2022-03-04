// ignore_for_file: prefer_const_constructors

import 'package:area/screens/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';

class SettingsState extends StatefulWidget {
  const SettingsState({Key? key}) : super(key: key);

  @override
  State<SettingsState> createState() => StatefulSettings();
}

class StatefulSettings extends State<SettingsState> {
  bool _dark = settings.dark_mode;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
              const SizedBox(height: 30.0),
              SwitchListTile(
                title: Text(
                  "Dark mode",
                  style: TextStyle(
                      fontSize: 18,
                      color: settings.dark_mode ? pc1 : pf1,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "" + _dark.toString(),
                  style: const TextStyle(
                    color: pc2,
                  ),
                ),
                value: _dark,
                onChanged: (val) {
                  if (settings.dark_mode == false) {
                    settings.dark_mode = true;
                  } else {
                    settings.dark_mode = false;
                  }
                  settings.applyChangeDark();
                  setState(() {
                    _dark = settings.dark_mode;
                  });
                },
              ),
              const SizedBox(height: 30.0),
              TextButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profilePage()),
                  ).then((_) => setState(() {}));
                },
                child: Text("Modify you profile"),
                style: TextButton.styleFrom(
                  side: BorderSide(color: pc3, width: 1),
                  primary: pf4,
                  shape: const BeveledRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  textStyle: TextStyle(
                      color: pf3,
                      fontSize: 20,
                      fontFamily: "Raleway",
                      fontWeight: FontWeight.w800),
                  elevation: 5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
