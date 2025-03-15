class Category {
  Category({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'].toString(),
      title: json['title'].toString(),
    );
  }
}
