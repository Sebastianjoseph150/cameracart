import 'package:camera_cart/Admin/edit.dart';
import 'package:camera_cart/Admin/addproduct.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/admindatabase/product.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({super.key});

  @override
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  late Box<Product> _productBox = Hive.box<Product>('products');
  int totalProducts = 0;

  @override
  void initState() {
    super.initState();
    _openBox();
    updateTotalProducts();
    getall();
  }

  Future<void> _openBox() async {
    _productBox = await Hive.openBox<Product>('products');
  }

  void updateTotalProducts() {
    setState(() {
      totalProducts = _productBox.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Product Listing'),
      ),
      body: ValueListenableBuilder(
        valueListenable: productlist,
        builder: (context, List<Product> adminlist, Widget? child) {
          return ListView.builder(
            itemCount: adminlist.length,
            itemBuilder: (context, index) {
              final product = adminlist[index];
              final img = product.image;
              final imageready = img != null ? base64Decode(img) : null;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 241, 240, 240),
                        offset: Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductEditingPage(
                            product: product,
                            index: index,
                            id: product.id,
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: product.image != null
                          ? Image.memory(
                              imageready!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.image,
                              ),
                            ),
                      title: Text(product.name),
                      subtitle: Text(product.category),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                    'Do you want to delete the product?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      delete(product.id);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
        onPressed: () {
          _navigateToAddPage();
        },
      ),
    );
  }

  void _navigateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductAddingPage()),
    );
  }
}
