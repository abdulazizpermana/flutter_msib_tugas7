import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/constant.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/blog_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List> getData() async {
    Uri uri = Uri.parse('${Constant.baseUrl}wp/v2/posts');
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      for(int i=0; i < jsonDecode(response.body).length; i++){
        final datum = Post.fromJSON(jsonDecode(response.body)[i]);
        posts.add(datum);
      }
      setState(() {});
      return posts;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterBlog'),
        actions: [
          IconButton(
            onPressed: (){}, 
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.person),
          )
          ],
      ),
      body:ListView.separated(
        itemBuilder: (context, index){
          final post = posts[index];
          return ListTile(
            title: Text(post.title?? ""),
            subtitle: Text(post.excerpt?? "", maxLines: 4,),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: posts.length,
      ),
    );
  }
}