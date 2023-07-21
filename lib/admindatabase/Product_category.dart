import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/Admin/addproduct.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';
import 'package:camera_cart/admindatabase/product.dart';
import 'dart:typed_data';

import 'package:camera_cart/user/details.dart';


import 'package:camera_cart/user/favbutton.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';

class UserCatListing2 extends StatefulWidget {
  final String category;

  const UserCatListing2({super.key, required this.category});

  @override
  _UserCatListing2State createState() => _UserCatListing2State();
}

enum SortCriteria { Name, Price }

class _UserCatListing2State extends State<UserCatListing2> {
  late Box<Product> _productBox = Hive.box<Product>('products');
  SortCriteria _sortCriteria = SortCriteria.Name;
  double _minPrice = 0; // Declare _minPrice variable
  double _maxPrice = double.infinity;

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _productBox = await Hive.openBox<Product>('products');
  }

  void _showFilterDialog() {
    final minPrice = TextEditingController();
    final maxPrice = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter by Price'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: minPrice,
                decoration: const InputDecoration(labelText: 'Min Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Update the text controller value
                  minPrice.text = value;
                },
              ),
              TextField(
                controller: maxPrice,
                decoration: const InputDecoration(labelText: 'Max Price'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  // Update the text controller value
                  maxPrice.text = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _minPrice = double.tryParse(minPrice.text) ?? 0;
                  _maxPrice = double.tryParse(maxPrice.text) ?? double.infinity;
                });
                Navigator.of(context).pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.category),
        actions: [
          PopupMenuButton<SortCriteria>(
            onSelected: (SortCriteria result) {
              setState(() {
                _sortCriteria = result;
              });
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SortCriteria>>[
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.Name,
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem<SortCriteria>(
                value: SortCriteria.Price,
                child: Text('Sort by Price'),
              ),
            ],
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: productlist,
        builder: (context, List<Product> adminlist, Widget? child) {
          final filteredList = adminlist
              .where((product) => product.category == widget.category)
              .toList();

          // Sort the list based on the selected criteria
          if (_sortCriteria == SortCriteria.Name) {
            filteredList.sort((a, b) => a.name.compareTo(b.name));
          } else if (_sortCriteria == SortCriteria.Price) {
            filteredList.sort((a, b) => a.price.compareTo(b.price));
          }

          if (filteredList.isEmpty) {
            return const Center(
              child: Text('No products'),
            );
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final product = filteredList[index];
                final img = product.image;
                final imageData = base64Decode(img);
                return ProductCard1(
                  imageUrl: imageData,
                  name: product.name,
                  price: product.price,
                  category: product.category,
                  discription: product.description,
                  id: product.id,
                );
              },
            );
          }
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

class ProductCard1 extends StatelessWidget {
  final Uint8List imageUrl;
  final String name;
  final String price;
  final String category;
  final String discription;
  final int id;

  const ProductCard1(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.category,
      required this.discription,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                    imageUrl: imageUrl,
                    name: name,
                    price: price,
                    category: category,
                    description: discription,
                    id: id,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.1)),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColorChangingButton(
                  wishlistItem: WishlistItem(
                category: category,
                name: name,
                price: price,
                image: imageUrl.toString(),
                description: discription,
                id: id,
              )),
              if (imageUrl != null)
                Image.memory(
                  imageUrl,
                  height: 150,
                  width: 200,
                )
              else
                const Placeholder(),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  price,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
