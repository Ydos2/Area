import 'package:flutter/material.dart';
import 'package:area/screens/home/home_screen.dart';
import 'package:area/screens/unkown/unkown_page.dart';
import 'package:area/screens/Login/home_view.dart';

class HandlePage extends StatelessWidget {
  final String pathName;
  const HandlePage({Key? key, required this.pathName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (pathName) {
      case 'home':
        return Scaffold(
          body: HomeScreen(),
        );
      case 'login':
        return Scaffold(
          body: HomeView(),
        );
      default:
        return Scaffold(
          body: UnkownPage(),
        );
    }
  }
}
