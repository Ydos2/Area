import 'package:area/constants.dart';
import 'package:area/settings.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    leading: const BackButton(),
    elevation: 0,
    backgroundColor: settings.dark_mode ? pf2 : pc3,
  );
}