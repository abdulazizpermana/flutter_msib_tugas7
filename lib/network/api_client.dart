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
