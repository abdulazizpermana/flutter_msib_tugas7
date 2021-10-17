import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/app_route.dart';
import 'package:flutter_msib_tugas7/common/constant.dart';
import 'package:flutter_msib_tugas7/model/req_login.dart';
import 'package:flutter_msib_tugas7/network/api_client.dart';
import 'package:flutter_msib_tugas7/widget/text_field_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;
  bool _showPassword = true;
  bool _onSend = false;

  @override
  void initState() {
    super.initState();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8.0),
          children: _listTextInput(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onSend ? null : _sendLogin,
        label: Text(_onSend ? 'loading...' : 'Login'),
      ),
    );
  }

  List<Widget> _listTextInput() {
    return <Widget>[
      const SizedBox(
        height: 230,
      ),
      const Center(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      TextFieldLogin(
        controller: _controllerEmail,
        labelText: 'Email',
        keyboardType: TextInputType.emailAddress,
        enable: !_onSend,
      ),
      TextFieldLogin(
        controller: _controllerPassword,
        labelText: 'Password',
        suffixIconData: _showPassword ? Icons.visibility_off : Icons.visibility,
        onPressedIcon: () {
          setState(() => _showPassword = !_showPassword);
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: _showPassword,
        enable: !_onSend,
      ),
      SizedBox(
        height: 30,
      ),
      const Center(
        child: Text(
          'Atau',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 45.0,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: const Text(
            "Continue Without Login",
          ),
        ),
      ),
    ];
  }

  Future<void> _sendLogin() async {
    setState(() => _onSend = true);
    ReqResLogin _reqResLogin = await ApiClients.getToken(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );
    if (_reqResLogin.token?.isNotEmpty ?? false) {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      await _preferences.setString(Constant.keyToken, _reqResLogin.token!);
      Navigator.pop(context, _reqResLogin.token!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _reqResLogin.error ?? 'Oops! Something went wrong...',
          ),
        ),
      );
    }
    setState(() => _onSend = false);
  }
}
