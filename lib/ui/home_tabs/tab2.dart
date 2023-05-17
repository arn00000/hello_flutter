import "package:flutter/material.dart";
import "package:hello_flutter/data/repository/product_repo_impl.dart";

import "../../data/model/product.dart";

class SecondTab extends StatefulWidget {
  const SecondTab({Key? key}) : super(key: key);

  @override
  State<SecondTab> createState() => _SecondTabState();
}

class _SecondTabState extends State<SecondTab> {
  Future<bool> _onConfirmDismiss(DismissDirection dir) async {
    if (dir == DismissDirection.endToStart) {
      return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Are you sure?"),
              content: const Text(
                  "The item will deleted and the action can not be undone"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text("YES")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: const Text("NO"))
              ],
            );
          });
    } else {
      return false;
    }
  }

  final repo = ProductRepoImpl();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final fetchedProducts = await repo.getProducts();
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      debugPrint("Failed to fetch products: $e");
      // Handle error
    }
  }

  void _deleteProduct(String id) async {
    await repo.deleteItem(id);
    _fetchProducts();
  }

  void _updateProduct(String id) async {
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
    _fetchProducts();
  }

  void _onClickAdd() async {
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
    _fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.cyan,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Card(
                        margin: const EdgeInsets.all(20),
                        elevation: 20,
                        child: Dismissible(
                          key: Key(product.id.toString()),
                          onDismissed: (dir) {
                            _deleteProduct(product.id!);
                          },
                          secondaryBackground: Container(
                            color: Colors.red.shade600,
                            child: const Center(
                              child: Text(
                                "Deleted",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          confirmDismiss: (dir) async {
                            // if (dir == DismissDirection.endToStart) {
                            //   return true;
                            // }
                            // return false;
                            return _onConfirmDismiss(dir);
                          },
                          background: Container(
                            color: Colors.green,
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              // <-- Add a background color to the container
                              color: Colors
                                  .white, // <-- Change the color to a different color from the background color of the Dismissible widget
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Title: ${product.title}",
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Description: ${product.category}",
                                      softWrap: true,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _updateProduct(product.id!);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue.shade700,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        _deleteProduct(product.id!);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade700,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_onClickAdd()},
        child: const Icon(Icons.add),
      ),
    );
  }
}
