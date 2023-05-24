import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../data/model/product.dart';

class FourthTab extends StatefulWidget {
  const FourthTab({Key? key}) : super(key: key);

  @override
  State<FourthTab> createState() => _FourthTabState();
}

class _FourthTabState extends State<FourthTab> {
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

  void _deleteProduct() async {
  }

  void _updateProduct() async {
  }

  List<Product> products = [];

  Future<void> getProducts() async {
    var collection = FirebaseFirestore.instance.collection("products");

    var querySnapshot = await collection.get();

    // var temp = <Product>[];

    for (var item in querySnapshot.docs) {
      var data = item.data();
      var product = Product.fromMap(data);
      setState(() {
      products.add(product);

      });
      debugPrint(product.toString());
    }

    // setState(() {
    //   products = temp;
    // });
    debugPrint(products.toString());
  }

  @override
  void initState() {
    super.initState();
    getProducts();
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
                            _deleteProduct();
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
                                        _updateProduct();
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
                                        _deleteProduct();
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {_onClickAdd()},
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
