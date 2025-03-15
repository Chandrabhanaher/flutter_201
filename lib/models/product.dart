class Product {
  Product(
      {required this.id,
      required this.title,
      required this.image_url,
      required this.categories,
      required this.price,
      required this.details});

  final String id;
  final String title;
  final String image_url;
  final List<String> categories;
  final double price;
  final String details;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'].toString(),
      image_url: json['image_url'].toString(),
      categories: json['categories'].cast<String>(),
      price: json['price'].toDouble(),
      details: json['details'].toString(),
    );
  }
}

class Cart {
  Cart({required this.pid});
  final String pid;
}

class WishItem {
  WishItem({required this.pid});
  final String pid;
}
