import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/app_route.dart';
import 'package:flutter_msib_tugas7/provider/login_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () => getToken().then(
        (value) {
          loginProvider.setToken(value);
          loginProvider.changeLoginStatus();
          Navigator.pushReplacementNamed(context, AppRoute.homeRoute);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Please Wait',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> getToken() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('loginToken') ?? '';
  }
}
