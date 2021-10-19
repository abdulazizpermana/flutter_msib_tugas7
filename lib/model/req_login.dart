import 'dart:convert';

class ReqResLogin {
  String? token;

  ReqResLogin({
    this.token = "",
  });

  factory ReqResLogin.fromJson(String str) {
    return ReqResLogin.fromMap(json.decode(str));
  }

  String toJson() {
    return json.encode(toMap());
  }

  factory ReqResLogin.fromMap(Map<String, dynamic> json) {
    return ReqResLogin(
      token: json["token"],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "token": token,
    };
  }
}
