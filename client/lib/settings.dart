import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Settings settings = Settings();

class Settings {
  bool dark_mode = false;
  String mail_actu = "";

  Future applyChangeDark() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('darkMode', this.dark_mode);
  }
}
