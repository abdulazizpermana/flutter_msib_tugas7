import 'package:flutter/material.dart';
import '../common/app_route.dart';
import '../provider/login_provider.dart';
import '../provider/post_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    Provider.of<LoginProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
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
          Consumer<LoginProvider>(
            builder: (context, provider, child) => IconButton(
              onPressed: () {
                if (provider.loginToken.isEmpty) {
                  moveToLoginPage();
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => _signOutDialog(context),
                  ).then(
                    (value) => provider.changeLoginStatus(),
                  );
                }
              },
              icon: (provider.loginStatus)
                  ? const Icon(
                      Icons.logout,
                      color: Colors.black,
                    )
                  : const Icon(
                      Icons.login,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) => (provider.loadingData)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  final post = provider.posts[index];
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
                itemCount: provider.posts.length,
              ),
      ),
    );
  }

  Future<void> _signOut() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.remove('loginToken');
    loginProvider.setToken('');
  }

  void moveToLoginPage() async {
    Navigator.pushNamed(
      context,
      AppRoute.loginRoute,
    );
  }
}
