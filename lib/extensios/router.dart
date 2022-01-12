import 'package:flutter/material.dart';
import 'package:web/main.dart';
import 'package:web/models/route_names.dart';
import 'package:web/models/routing_data.dart';
import 'package:web/screens/AuthTest.dart';
import 'package:web/screens/TestTwo.dart';
import 'package:web/extensios/string_extensions.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    case HomeRoute:
      return _getPageRoute(Background(), settings);
    case AboutRoute:
      return _getPageRoute(Background(), settings);
    default:
      return _getPageRoute(Background(), settings);
  }
}
PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}
class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({this.child, this.routeName})
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