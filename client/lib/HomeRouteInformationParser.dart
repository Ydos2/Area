import 'package:flutter/material.dart';

import 'package:area/HomeRoutePath.dart';

class HomeRouteInformationParser extends RouteInformationParser<HomeRoutePath> {
  @override
  Future<HomeRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    if (uri.pathSegments.length == 0) {
      return HomeRoutePath.home();
    }

    if (uri.pathSegments.length == 1) {
      final pathName = uri.pathSegments.elementAt(0).toString();
      if (pathName == null) return HomeRoutePath.unKown();
      return HomeRoutePath.otherPage(pathName);
    }

    return HomeRoutePath.unKown();
  }

  @override
  RouteInformation? restoreRouteInformation(HomeRoutePath homeRoutePath) {
    if (homeRoutePath.isUnkown) return RouteInformation(location: '/error');
    if (homeRoutePath.isHomePage) return RouteInformation(location: '/');
    if (homeRoutePath.isOtherPage)
      return RouteInformation(location: '/${homeRoutePath.pathName}');

    return null;
  }
}
