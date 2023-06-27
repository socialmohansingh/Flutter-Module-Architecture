import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

class UrlHandlerInformationParser
    extends RouteInformationParser<NavigationRouteState> {
  // Url to navigation state
  @override
  Future<NavigationRouteState> parseRouteInformation(
      RouteInformation routeInformation) async {
    return DefaultRoute(endPath: routeInformation.location?.substring(1) ?? "");
  }

  // Navigation state to url
  @override
  RouteInformation restoreRouteInformation(NavigationRouteState configuration) {
    return RouteInformation(location: '/${configuration.endPath}');
  }
}
