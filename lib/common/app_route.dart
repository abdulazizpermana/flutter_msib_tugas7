import 'package:flutter/widgets.dart';
import 'package:flutter_msib_tugas7/pages/home.dart';
import 'package:flutter_msib_tugas7/pages/login.dart';

class AppRoute {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    loginRoute: (BuildContext context) {
      return const LoginPage();
    },
    homeRoute: (BuildContext context) {
      return const HomePage();
    },
  };
}
