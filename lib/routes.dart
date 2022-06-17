import 'package:don/pages/authenticated_screen.dart';
import 'package:don/pages/start_screen.dart';
import 'package:flutter/cupertino.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "/": (context) => StartScreen(),
  "/authenticated": (context) => AuthenticatedScreen(),
};