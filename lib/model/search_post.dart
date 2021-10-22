import 'dart:convert';

List<SearchPost> searchPostFromJson(String str) => List<SearchPost>.from(
      json.decode(str).map(
            (x) => SearchPost.fromJson(x),
          ),
    );

class SearchPost {
  int? id;
  String? title;
  String? url;
  SearchPost({
    this.id,
    this.title,
    this.url,
  });

  factory SearchPost.fromJson(Map<String, dynamic> json) {
    return SearchPost(
      id: json["id"],
      title: json["title"],
      url: json["url"],
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "id": id,
      "title": title,
      "url": url,
    };
  }
}
