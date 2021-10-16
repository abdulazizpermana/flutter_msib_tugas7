import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  String hintText;
  final ValueChanged<String> onChanged;
  SearchWidget({
    required this.hintText,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
        decoration: const InputDecoration(
          hintText: 'Ketikkan Judul Post',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: widget.onChanged,
      ),
    );
  }
}
