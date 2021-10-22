import 'package:flutter/widgets.dart';
import '../model/blog_data.dart';
import '../network/api_client.dart';

class PostProvider extends ChangeNotifier {
  bool _lastPost = false;
  bool get lastPost => _lastPost;

  int _page = 1;
  int get page => _page;
  void setPage() {
    _page++;
    _getMorePost();
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _loadingData = true;
  bool get loadingData => _loadingData;
  Future getAllPost() async {
    final list = await ApiClient.getData('$_page');
    _posts.addAll(list);
    (_posts.isEmpty) ? _loadingData = true : _loadingData = false;
    notifyListeners();
  }

  Future _getMorePost() async {
    final list = await ApiClient.getData('$_page');
    if (list.isNotEmpty) {
      _posts.addAll(list);
    } else {
      _lastPost = true;
    }
    notifyListeners();
  }

  void init() {
    _posts = [];
    _lastPost = false;
    _page = 1;
  }
}
