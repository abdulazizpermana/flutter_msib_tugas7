import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  String hintText;
  TextEditingController controller;
  VoidCallback onPressed;

  SearchWidget({
    required this.controller,
    required this.hintText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
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
        controller: widget.controller,
        decoration: InputDecoration(
          prefixText: '    ',
          hintText: 'Ketikkan Judul Post',
          suffixIcon: IconButton(
            onPressed: widget.onPressed,
            icon: const Icon(Icons.search),
          ),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onEditingComplete: widget.onPressed,
      ),
    );
  }
}
