import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:hello_flutter/data/model/product.dart';
import 'package:http/http.dart' as http;

class ProductRepoImpl {
  Future<List<Product>> getProducts() async {
    final res = await http
        .get(Uri.parse("https://product-catalogue-p3qa.onrender.com/products"));
    if (res.statusCode == 200) {
      final List<dynamic> responseBody = jsonDecode(res.body);
      final List<Product> products = responseBody
          .map((item) => Product.fromMap(item))
          .toList()
          .cast<Product>();
      debugPrint(res.body);
      return products;
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<int> insertItem(Product product) async {
    final res = await http.post(
        Uri.parse("https://product-catalogue-p3qa.onrender.com/products"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(product.toMap()));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to insert");
    }
  }

  Future<int> deleteItem(String id) async {
    final res = await http.delete(
        Uri.parse("https://product-catalogue-p3qa.onrender.com/products/$id"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to delete");
    }
  }

  Future<int> updateItem(String id, Product product) async {
    final res = await http.put(
        Uri.parse("https://product-catalogue-p3qa.onrender.com/products/$id"),
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: jsonEncode(product.toMap()));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to update");
    }
  }

  Future<int> getItemById(int id) async {
    final res = await http.get(
        Uri.parse("https://product-catalogue-p3qa.onrender.com/products/$id"));

    if (res.statusCode == 200) {
      return jsonDecode(res.body)["_id"] ?? -1;
    } else {
      throw Exception("Failed to delete");
    }
  }
}
