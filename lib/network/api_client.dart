import '../model/req_login.dart';
import 'package:http/http.dart';
import '../model/blog_data.dart';
import '../model/search_post.dart';
import '../common/constant.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static Future<dynamic> getSearchData(String query, String page) async {
    Uri _uri =
        Uri.parse('${Constant.baseUrl}wp/v2/search?search=$query&page=$page');
    final response = await http.get(_uri);
    if (response.statusCode == 200) {
      return searchPostFromJson(response.body);
    } else {
      return [];
    }
  }

  static Future<List<Post>> getData(String page) async {
    Uri uri = Uri.parse('${Constant.baseUrl}wp/v2/posts?page=$page');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      return postFromJson(response.body);
    } else {
      return [];
    }
  }
}

class ApiClients {
  static Future<ReqResLogin> getToken(
      {required String email, required String password}) async {
    Response _response = await post(
      Uri.parse("${Constant.baseUrl}jwt-auth/v1/token"),
      body: <String, String>{"username": email, "password": password},
    );
    return ReqResLogin.fromJson(_response.body);
  }
}
