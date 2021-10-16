import 'package:flutter_msib_tugas7/model/search_post.dart';

import '../common/constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  static Future<List<SearchPost>> getSearchData(String query) async {
    Uri _uri = Uri.parse('${Constant.baseUrl}wp/v2/search');
    final response = await http.get(_uri);
    if (response.statusCode == 200) {
      final List datas = json.decode(response.body);
      return datas.map((json) => SearchPost.fromJson(json)).where((element) {
        final titleLower = element.title!.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
