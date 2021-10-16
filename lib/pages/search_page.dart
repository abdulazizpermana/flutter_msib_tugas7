import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/model/search_post.dart';
import 'package:flutter_msib_tugas7/network/api_client.dart';
import 'package:flutter_msib_tugas7/widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _onSearch = false;
  List<SearchPost> searchPosts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _onSearch = true;
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Search'),
      ),
      body: Column(children: [
        SearchWidget(
          hintText: 'Ketikkan Judulnya',
          onChanged: _searchPost,
        ),
        Expanded(
          child: (_onSearch)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : buildPost(),
        )
      ]),
    );
  }

  Future init() async {
    final resultPost = await ApiClient.getSearchData('');
    setState(() {
      _onSearch = false;
      searchPosts = resultPost;
    });
  }

  Future<void> _searchPost(String query) async {
    setState(() {
      _onSearch = true;
    });
    final resultPost = await ApiClient.getSearchData(query);
    setState(() {
      _onSearch = false;
      searchPosts = resultPost;
    });
  }

  Widget buildPost() {
    return (searchPosts.isEmpty)
        ? const Center(
            child: Text('Judul Tidak Ditemukan'),
          )
        : ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: searchPosts.length,
            itemBuilder: (context, index) {
              final post = searchPosts[index];
              return ListTile(
                title: Text(post.title!),
                subtitle: Text(post.url!),
              );
            });
  }
}
