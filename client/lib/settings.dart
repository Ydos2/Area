import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Settings settings = Settings();

class Settings {
  bool dark_mode = false;
  bool newsReddit = false;
  String mail_actu = "";

  final titles = [];
  final subtitles = [];
  final icon = [];

  Future applyChangeDark() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('darkMode', this.dark_mode);
  }

  Future applyChangeNews() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool('newsReddit', this.newsReddit);
  }
}
