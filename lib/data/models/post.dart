import 'package:flutter_blog/data/models/user.dart';
import 'package:intl/intl.dart';

class Post {
  final int? id;
  final String? title;
  final String? content;
  final User? user;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Post({
    this.id,
    this.title,
    this.content,
    this.user,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "user": user,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  // 통신을 위해서 json 처럼 생긴 문자열 {"id":1} => Dart 오브젝트

  Post.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        content = json["content"],
        user = User.fromJson(json["user"]),
        createdAt = DateFormat("yyyy-mm-dd").parse(json["created"]),
        updatedAt = DateFormat("yyyy-mm-dd").parse(json["updated"]);

  String getUpdated() {
    return DateFormat.MMMd().format(updatedAt!);
  }
}
