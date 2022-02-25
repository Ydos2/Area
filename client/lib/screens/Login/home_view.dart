import 'package:flutter/material.dart';
import 'package:area/screens/Login/home_desktop.dart';
import 'package:area/screens/Login/home_mobile.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HomeMobile(),
      desktop: HomeDesktop(),
    );
  }
}