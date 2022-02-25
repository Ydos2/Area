import 'package:flutter/material.dart';
import 'package:area/screens/Login/home_desktop.dart';
import 'package:area/screens/Login/home_mobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatelessWidget {
  static const String route = '/login';
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(),
      desktop: HomeDesktop(),
    );
  }
}