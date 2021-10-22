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
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.init();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        (searchProvider.lastPost) ? null : searchProvider.setPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman Search'),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, child) => Column(
          children: [
            SearchWidget(
              controller: controller,
              hintText: 'Ketikkan Kata Kunci',
              onPressed: () => searchProvider.setQuery(controller.text),
              onChanged: (String value) {
                (value.isEmpty) ? {searchProvider.setQuery(value)} : null;
              },
            ),
            Expanded(
              child: (searchProvider.onSearch)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : buildPost(),
            ),
          ],
        ),
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
                      controller: _scrollController,
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
