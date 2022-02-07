import 'package:flutter/material.dart';
import 'package:area/screens/home/home_screen.dart';
import 'package:area/screens/main/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

import 'package:area/screens/Welcome/welcome_screen.dart';
import 'package:area/constants.dart';
import 'package:area/HomeRouterDelegate.dart';
import 'package:area/HomeRouteInformationParser.dart';
import 'package:area/locator.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: HomeRouterDelegate(),
      routeInformationParser: HomeRouteInformationParser(),
      debugShowCheckedModeBanner: false,
      title: 'Area',
      // we are using dark theme and we modify it as our need
      theme: ThemeData.dark().copyWith(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        canvasColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .copyWith(
              bodyText1: TextStyle(color: bodyTextColor),
              bodyText2: TextStyle(color: bodyTextColor),
            ),
      ),
      //initialRoute: WelcomeScreen.route,
      //onGenerateRoute: RouteConfiguration.onGenerateRoute,
      //home: WelcomeScreen(),
      //home: HomeScreen(),
    );
  }
}

class Path {
  const Path(this.pattern, this.builder);

  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    Path(
      r'^' + WelcomeScreen.route,
      (context, match) => WelcomeScreen(),
    ),
    Path(
      r'^' + HomeScreen.route,
      (context, match) => HomeScreen(),
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name.toString())) {
        final firstMatch = regExpPattern.firstMatch(settings.name.toString());
        final match =
            (firstMatch?.groupCount == 1) ? firstMatch!.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match.toString()),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}
