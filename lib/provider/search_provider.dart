import 'package:flutter/widgets.dart';
import '../model/search_post.dart';
import '../network/api_client.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchPost> _searchPosts = [];
  List<SearchPost> get searchPosts => _searchPosts;

  String _query = '';
  String get query => _query;
  void setQuery(String value) {
    _query = value;
    notifyListeners();
    _getSearchPost();
  }

  String _message = '';
  String get message => _message;
  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  bool _onSearch = false;
  bool get onSearch => _onSearch;

  Future<dynamic> _getSearchPost() async {
    if (_query.isNotEmpty) {
      changeOnSearch();
      _searchPosts = await ApiClient.getSearchData(_query);
      (_searchPosts.isEmpty)
          ? setMessage('Judul Tidak Ditemukan')
          : setMessage('');
      changeOnSearch();
    } else {
      setMessage('');
    }
  }

  void changeOnSearch() {
    _onSearch = !_onSearch;
    notifyListeners();
  }
}
