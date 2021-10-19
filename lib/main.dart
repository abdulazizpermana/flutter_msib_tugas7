import 'package:flutter/material.dart';
import '../pages/splash_screen.dart';
import '../common/app_route.dart';
import '../pages/home.dart';
import '../provider/login_provider.dart';
import '../provider/post_provider.dart';
import '../provider/search_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: AppRoute.routes,
      ),
    );
  }
}
