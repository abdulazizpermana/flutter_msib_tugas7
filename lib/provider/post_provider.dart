import 'package:flutter/widgets.dart';
import '../model/blog_data.dart';
import '../network/api_client.dart';

class PostProvider extends ChangeNotifier {
  PostProvider() {
    _getAllPost();
  }

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _loadingData = true;
  bool get loadingData => _loadingData;
  Future<dynamic> _getAllPost() async {
    _posts = await ApiClient.getData();
    (_posts.isEmpty) ? _loadingData = true : _loadingData = false;
    notifyListeners();
  }
}
