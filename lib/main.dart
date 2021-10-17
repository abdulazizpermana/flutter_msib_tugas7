import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/app_route.dart';
import 'package:flutter_msib_tugas7/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: AppRoute.routes,
    );
  }
}
