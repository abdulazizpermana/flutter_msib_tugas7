import 'package:flutter/widgets.dart';
import '../model/search_post.dart';
import '../network/api_client.dart';

class SearchProvider extends ChangeNotifier {
  List<SearchPost> _searchPosts = [];
  List<SearchPost> get searchPosts => _searchPosts;

  bool _lastPost = false;
  bool get lastPost => _lastPost;

  int _page = 1;
  int get page => _page;
  void setPage() {
    _page = _page + 1;
    _getMorePost();
  }

  String _query = '';
  String get query => _query;
  void setQuery(String value) {
    _query = value;
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

  void init() {
    _searchPosts = [];
    _message = '';
    _page = 1;
    _lastPost = false;
  }

  Future<dynamic> _getSearchPost() async {
    if (_query.isNotEmpty) {
      changeOnSearch();
      final list = await ApiClient.getSearchData(_query, '$_page');
      _searchPosts.addAll(list);
      (_searchPosts.isEmpty)
          ? setMessage('Kata Kunci Tidak Ditemukan')
          : setMessage('');
      changeOnSearch();
    } else {
      init();
      setMessage('');
    }
  }

  Future<dynamic> _getMorePost() async {
    List<SearchPost> list = await ApiClient.getSearchData(_query, '$_page');
    if (list.isNotEmpty) {
      _searchPosts.addAll(list);
    } else {
      _lastPost = true;
    }
    notifyListeners();
  }

  void changeOnSearch() {
    _onSearch = !_onSearch;
    notifyListeners();
  }
}
