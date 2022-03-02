import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:area/settings.dart';
import 'package:area/constants.dart';
import 'package:area/components/NavBar.dart';

class DiscordState extends StatefulWidget {
  const DiscordState({Key? key}) : super(key: key);

  @override
  State<DiscordState> createState() => StatefulDiscord();
}

class StatefulDiscord extends State<DiscordState> {
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
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}