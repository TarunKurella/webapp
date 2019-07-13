class Post {
  int p = 0;
  String id = "";
  String name = "";

  Post({this.p, this.name, this.id});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      p: json['p'],
      name: json['name'],
      id: json['id']
    );
  }
}