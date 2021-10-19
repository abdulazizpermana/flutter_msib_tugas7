import 'package:flutter/material.dart';
import '../provider/search_provider.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatefulWidget {
  String hintText;

  SearchWidget({
    required this.hintText,
    Key? key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          prefixText: '    ',
          hintText: 'Ketikkan Judul Post',
          suffixIcon: IconButton(
            onPressed: () {
              searchProvider.setQuery(_searchController.text);
            },
            icon: const Icon(Icons.search),
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
