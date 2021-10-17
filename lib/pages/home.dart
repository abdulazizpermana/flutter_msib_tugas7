import 'package:flutter/material.dart';
import 'package:flutter_msib_tugas7/common/app_route.dart';
import 'package:flutter_msib_tugas7/common/constant.dart';
import 'package:flutter_msib_tugas7/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_client.dart';
import '../pages/search_page.dart';

import '../model/blog_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterBlog'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchPage(),
                ),
              );
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            icon: Icon(Icons.person),
          )
        ],
      ),
      body: (posts.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                final post = posts[index];
                return ListTile(
                  title: Text(post.title ?? ""),
                  subtitle: Text(
                    post.excerpt ?? "",
                    maxLines: 4,
                  ),
                  trailing: Icon(Icons.more_vert),
                  isThreeLine: true,
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: posts.length,
            ),
    );
  }

  Future init() async {
    await ApiClient.getData();
    setState(() {});
  }
}

Future<void> _signOut(BuildContext context) async {
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  await _preferences.remove(Constant.keyToken);
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoute.loginRoute,
    (Route route) => false,
  );
}
