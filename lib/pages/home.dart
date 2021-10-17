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

  String token = '';

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) token = args;

    Widget _signOutDialog(BuildContext context) {
      return AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await _signOut();
              Navigator.pop(context);
            },
            child: const Text('YES'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('NO'),
          ),
        ],
      );
    }

    Widget iconStatus() => (token.isEmpty)
        ? const Icon(
            Icons.login,
          )
        : const Icon(
            Icons.logout,
            color: Colors.black,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterBlog'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoute.searchRoute,
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              if (token.isEmpty) {
                moveToLoginPage();
              } else {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => _signOutDialog(context),
                ).then(
                  (value) => setState(() {}),
                );
              }
            },
            icon: iconStatus(),
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
                  trailing: const Icon(Icons.more_vert),
                  isThreeLine: true,
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: posts.length,
            ),
    );
  }

  Future init() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    token = _preferences.getString(Constant.keyToken) ?? '';
    await ApiClient.getData();
    setState(() {});
  }

  Future<void> _signOut() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.remove(Constant.keyToken);
    token = _preferences.getString(Constant.keyToken) ?? '';
  }

  void moveToLoginPage() async {
    final getToken = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
    setState(() {
      token = getToken;
    });
  }
}
