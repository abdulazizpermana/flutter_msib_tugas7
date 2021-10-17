// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/app_route.dart';
import 'package:flutter_msib_tugas7/common/constant.dart';
import 'package:flutter_msib_tugas7/model/req_login.dart';
import 'package:flutter_msib_tugas7/network/api_client.dart';
import 'package:flutter_msib_tugas7/widget/text_field_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: Icon(Icons.list),
//         title: Text("Formulir"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             child: Container(
//               padding: EdgeInsets.all(10.0),
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Login",
//                     style: TextStyle(
//                       fontSize: 25,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       hintText: "Username",
//                       labelText: "Username atau email",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20),
//                   ),
//                   TextField(
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       labelText: "Password",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 20),
//                   ),
//                   Container(
//                     width: 100,
//                     height: 45,
//                     child: TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: Color(0xff1597E5),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       onPressed: () {},
//                       child: Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Color(0xffffffff),
//                           fontSize: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
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
      SizedBox(
        height: 230,
      ),
      Center(
        child: Text(
          'Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      TextFieldLogin(
        controller: _controllerEmail,
        labelText: 'Email',
        suffixIconData: Icons.info,
        onPressedIcon: () {
          _controllerEmail.text = Constant.trueEmail;
        },
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
      Center(
        child: Text(
          'Atau',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
      ),
      SizedBox(
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
          child: Text(
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
      Navigator.pushReplacementNamed(
        context,
        AppRoute.homeRoute,
        arguments: _reqResLogin.token,
      );
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
