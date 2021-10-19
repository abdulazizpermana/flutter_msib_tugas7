import 'package:flutter/material.dart';
import '../model/req_login.dart';
import '../network/api_client.dart';
import '../provider/login_provider.dart';
import '../widget/text_field_login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _controllerEmail;
  late TextEditingController _controllerPassword;

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
        child: _buildListTextInput(),
      ),
      floatingActionButton: Consumer<LoginProvider>(
        builder: (
          context,
          login,
          child,
        ) {
          return FloatingActionButton.extended(
            onPressed: login.onSend ? null : () => _sendLogin(context),
            label: Text(login.onSend ? 'loading...' : 'Login'),
          );
        },
      ),
    );
  }

  Widget _buildListTextInput() {
    return Consumer<LoginProvider>(
      builder: (
        context,
        loginProvider,
        child,
      ) =>
          ListView(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(8),
        children: [
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
            enable: !loginProvider.onSend,
          ),
          TextFieldLogin(
            controller: _controllerPassword,
            labelText: 'Password',
            suffixIconData: loginProvider.hidePassword
                ? Icons.visibility_off
                : Icons.visibility,
            onPressedIcon: () => loginProvider.hidingPassword(),
            keyboardType: TextInputType.visiblePassword,
            obscureText: loginProvider.hidePassword,
            enable: !loginProvider.onSend,
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
        ],
      ),
    );
  }

  Future<void> _sendLogin(BuildContext context) async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    loginProvider.changeSendingStatus();
    ReqResLogin _reqResLogin = await ApiClients.getToken(
      email: _controllerEmail.text,
      password: _controllerPassword.text,
    );
    if (_reqResLogin.token?.isNotEmpty ?? false) {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      await _preferences.setString('loginToken', _reqResLogin.token!);
      loginProvider.setToken(_reqResLogin.token!);
      loginProvider.changeLoginStatus();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Oops! Something went wrong...',
          ),
        ),
      );
    }
    loginProvider.changeSendingStatus();
  }
}
