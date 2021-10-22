import 'dart:convert';

List<Post> postFromJson(String str) => List<Post>.from(
      json.decode(str).map(
            (x) => Post.fromJSON(x),
          ),
    );

class Post {
  int? id;
  String? title;
  String? author;
  String? excerpt;
  String? date;
  String? content;

  Post({
    required this.content,
    required this.id,
    required this.title,
    required this.excerpt,
    required this.date,
    required this.author,
  });

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title']['rendered'],
        content: json['content']['rendered'],
        date: json['date'] != null
            ? json['date'].toString().replaceFirst('T', ' ')
            : null,
        excerpt: json['excerpt']['rendered'],
        author: json['author'].toString());
  }
}
