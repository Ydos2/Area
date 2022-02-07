import 'package:flutter/material.dart';

class HomeRoutePath {
  final String pathName;
  final bool isUnkown;

  HomeRoutePath.home()
      : pathName = 'home',
        isUnkown = false;

  HomeRoutePath.otherPage(this.pathName) : isUnkown = false;

  HomeRoutePath.unKown()
      : pathName = '',
        isUnkown = true;

  bool get isHomePage => pathName == null;
  bool get isOtherPage => pathName != null;
}
