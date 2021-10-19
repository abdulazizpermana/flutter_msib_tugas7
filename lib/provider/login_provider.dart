import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool _hidePassword = true;
  bool get hidePassword => _hidePassword;

  bool _onSend = false;
  bool get onSend => _onSend;

  String _loginToken = '';
  String get loginToken => _loginToken;

  bool _loginStatus = false;
  bool get loginStatus => _loginStatus;

  void hidingPassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  void setToken(String token) {
    _loginToken = token;
  }

  void changeLoginStatus() {
    _loginToken.isNotEmpty ? _loginStatus = true : _loginStatus = false;
    notifyListeners();
  }

  void changeSendingStatus() {
    _onSend = !_onSend;
    notifyListeners();
  }
}
