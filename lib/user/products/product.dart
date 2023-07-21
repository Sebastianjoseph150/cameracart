import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/Admin/addproduct.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';
import 'package:camera_cart/admindatabase/product.dart';

import 'dart:convert';

class UserCatListing extends StatefulWidget {
  const UserCatListing({super.key});

  @override
  _UserCatListingState createState() => _UserCatListingState();
}

class _UserCatListingState extends State<UserCatListing> {
  late Box<Product> _productBox = Hive.box<Product>('products');

  @override
  void initState() {
    super.initState();
    _openBox();
  }

  Future<void> _openBox() async {
    _productBox = await Hive.openBox<Product>('products');
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
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: adminlist.length,
            itemBuilder: (context, index) {
              final product = adminlist[index];
              final img = product.image;

              final imageData = img != null ? base64Decode(img) : null;
              return ProductCard(
                  imageUrl: imageData,
                  name: product.name,
                  price: product.price);
            },
          );
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

class ProductCard extends StatelessWidget {
  final Uint8List? imageUrl;
  final String name;
  final String price;

  const ProductCard({super.key, 
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => Details()),
      //   );
      // },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.1)),
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ColorChangingButton(
              //     wishlistItem: WishlistItem(
              //   name: name,
              //   price: price,
              //   image: imageUrl.toString(),
              // )),
              if (imageUrl != null)
                Image.memory(
                  imageUrl!,
                  height: 150,
                  width: 200,
                )
              else
                const Placeholder(), // Placeholder or alternative content for missing image
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
              //
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
