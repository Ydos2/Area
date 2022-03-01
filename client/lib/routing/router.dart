import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:area/routing/route_names.dart';

import 'package:area/screens/home/home_screen.dart';
import 'package:area/screens/Login/home_view.dart';
import 'package:area/screens/unkown/unkown_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeRoute:
      return _getPageRoute(HomeScreen(), settings);
    case LoginRoute:
      return _getPageRoute(HomeView(), settings);
    // case WelcomeRoute:
    //   return _getPageRoute(WelcomeScreen(), settings);
    default:
      return _getPageRoute(UnkownPage(), settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name.toString());
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
