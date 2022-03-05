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
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: "Raleway",
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: settings.dark_mode ? pc1 : pf2,
          ),
        ),
        backgroundColor: settings.dark_mode ? pf2 : pc2,
        elevation: 0,
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
                      fontSize: 20,
                      fontFamily: "Raleway",
                      color: settings.dark_mode ? pc1 : pf1,
                      fontWeight: FontWeight.w800),
                ),
                subtitle: Text(
                  "" + _dark.toString(),
                  style: TextStyle(
                    color: settings.dark_mode ? pc1 : pf1,
                    fontFamily: "Raleway",
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
              ListTile(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => profilePage()),
                  ).then((_) => setState(() {}));
                },
                leading: Text(
                  "Modify Your Profile",
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: settings.dark_mode ? pc1 : pf1,
                  ),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: settings.dark_mode ? pc1 : pf1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
