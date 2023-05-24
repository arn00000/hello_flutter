import 'package:flutter/cupertino.dart';

import '../data/model/product.dart';
import '../data/repository/product_repo_impl.dart';

class SecondTabProvider extends ChangeNotifier {
  final repo = ProductRepoImpl();

  void deleteProduct(String id, Function fetchProducts) async {
    await repo.deleteItem(id);
    fetchProducts();
    notifyListeners();
  }

  void updateProduct(String id, Function fetchProducts) async {
    await repo.updateItem(
        id,
        Product(
            id: id,
            title: "Old",
            description: "Old",
            brand: "Old",
            category: "Old",
            price: 2,
            discountPercentage: 2,
            rating: 2,
            stock: 1,
            thumbnail: "thumbnail"));
    fetchProducts();
    notifyListeners();
  }

  void onClickAdd(Function fetchProducts) async {
    await repo.insertItem(Product(
        title: "New",
        description: "New",
        brand: "New",
        category: "New",
        price: 2,
        discountPercentage: 2,
        rating: 2,
        stock: 1,
        thumbnail: "thumbnail"));
    fetchProducts();
    notifyListeners();
  }
}
