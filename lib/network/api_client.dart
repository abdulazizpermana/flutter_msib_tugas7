import 'package:flutter_msib_tugas7/model/req_login.dart';
import 'package:http/http.dart';

import '../model/blog_data.dart';
import '../model/search_post.dart';
import '../common/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static Future<List<SearchPost>> getSearchData(String query) async {
    Uri _uri = Uri.parse('${Constant.baseUrl}wp/v2/search');
    final response = await http.get(_uri);
    if (response.statusCode == 200) {
      final List _datas = json.decode(response.body);
      return _datas.map((json) => SearchPost.fromJson(json)).where((element) {
        final titleLower = element.title!.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }

  static Future<List> getData() async {
    Uri uri = Uri.parse('${Constant.baseUrl}wp/v2/posts');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      for (int i = 0; i < jsonDecode(response.body).length; i++) {
        final datum = Post.fromJSON(jsonDecode(response.body)[i]);
        posts.add(datum);
      }
      return posts;
    } else {
      throw Exception('Failed to load album');
    }
  }
}

class ApiClients {
  static Future<ReqResLogin> getToken(
      {required String email, required String password}) async {
    Response _response = await post(
      Uri.parse("https://gits-msib.my.id/wp-json/jwt-auth/v1/token"),
      body: <String, String>{"username": email, "password": password},
    );

    return ReqResLogin.fromJson(_response.body);
  }
}
