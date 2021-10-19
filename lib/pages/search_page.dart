import 'package:flutter/material.dart';
import '../provider/search_provider.dart';
import '../widget/search_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Search'),
      ),
      body: Column(
        children: [
          SearchWidget(
            hintText: 'Ketikkan Judulnya',
          ),
          Consumer<SearchProvider>(
            builder: (context, searchProvider, child) => Expanded(
              child: (searchProvider.onSearch)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildPost(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPost() {
    return Consumer<SearchProvider>(
      builder: (context, searchProvider, child) =>
          (searchProvider.query.isEmpty)
              ? Center(
                  child: Text(searchProvider.message),
                )
              : (searchProvider.searchPosts.isEmpty)
                  ? Center(
                      child: Text(searchProvider.message),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: searchProvider.searchPosts.length,
                      itemBuilder: (context, index) {
                        final post = searchProvider.searchPosts[index];
                        return ListTile(
                          title: Text(post.title!),
                          subtitle: Text(post.url!),
                        );
                      },
                    ),
    );
  }
}
