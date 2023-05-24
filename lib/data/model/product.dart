import 'dart:core';

class Product {
  final String? id;
  final String title;
  final String description;
  final String brand;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final String? thumbnail;

  Product(
      {this.id,
      required this.title,
      required this.description,
      required this.brand,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      this.thumbnail});

  Map<String, dynamic> toMap() {
    return {
      // "id":id,
      "title": title,
      "description": description,
      "brand": brand,
      "category": category,
      "price": price,
      "discountPercentage": discountPercentage,
      "rating": rating,
      "stock": stock,
      "thumbnail": thumbnail,
    };
  }

  static fromMap(Map<String, dynamic> map) {
    return Product(
      id: map["_id"],
      title: map["title"],
      brand: map["brand"],
      category: map["category"],
      description: map["description"],
      price: map["price"] is int ? map["price"].toDouble() : map["price"],
      discountPercentage: map["discountPercentage"] is int
          ? map["discountPercentage"].toDouble()
          : map["discountPercentage"] ?? 0.0,
      rating: map["rating"] is int ? map["rating"].toDouble() : map["rating"],
      stock: map["stock"],
      thumbnail: map["thumbnail"],
    );
  }

  @override
  String toString() {
    return "Product(title: $title brand:$brand description:$description category:$category )";
  }
}
