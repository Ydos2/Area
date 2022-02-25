// ignore_for_file: avoid_print, file_names, unused_import

import 'package:area/locator.dart';
import 'package:area/routing/route_names.dart';
import 'package:area/routing/router.dart';
import 'package:flutter/material.dart';

import 'package:area/HomeRoutePath.dart';
import 'package:area/screens/Welcome/welcome_screen.dart';
import 'package:area/screens/unkown/unkown_page.dart';
import 'package:area/screens/handle/handle_page.dart';
import 'package:area/screens/home/home_screen.dart';

import 'package:area/services/navigation_service.dart';

class HomeRouterDelegate extends RouterDelegate<HomeRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<HomeRoutePath> {
  String pathName = '';
  bool isError = false;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  HomeRoutePath get currentConfiguration {
    if (isError) return HomeRoutePath.unKown();

    if (pathName == null) return HomeRoutePath.home();

    return HomeRoutePath.otherPage(pathName);
  }

  void onTapped(String path) {
    pathName = path;
    print(pathName);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    /*return Navigator(
      key: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );*/
    return Navigator(
        key: locator<NavigationService>().navigatorKey,
        //onGenerateRoute: generateRoute,
        //initialRoute: HomeRoute,
        pages: [
          MaterialPage(
            key: ValueKey('UnknownPage'),
            child: UnkownPage(),
          ),
          if (isError)
            MaterialPage(key: ValueKey('UnknownPage'), child: UnkownPage())
          else if (pathName != null)
            // ici envoyer l'endroit
            MaterialPage(
                key: ValueKey(pathName),
                child: HandlePage(
                  pathName: pathName,
                ))
        ],
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;

          pathName = '';
          isError = false;
          notifyListeners();

          return true;
        });
  }

  @override
  Future<void> setNewRoutePath(HomeRoutePath homeRoutePath) async {
    if (homeRoutePath.isUnkown) {
      pathName = '';
      isError = true;
      return;
    }

    if (homeRoutePath.isOtherPage) {
      if (homeRoutePath.pathName != null) {
        pathName = homeRoutePath.pathName;
        isError = false;
        return;
      } else {
        isError = true;
        return;
      }
    } else {
      pathName = '';
    }
  }
}
