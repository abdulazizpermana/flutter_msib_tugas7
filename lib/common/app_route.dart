import 'package:flutter/widgets.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/search_page.dart';

class AppRoute {
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String searchRoute = '/search';
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    loginRoute: (BuildContext context) {
      return const LoginPage();
    },
    homeRoute: (BuildContext context) {
      return const HomePage();
    },
    searchRoute: (BuildContext context) {
      return const SearchPage();
    },
  };
}
