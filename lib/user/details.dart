import 'package:flutter/material.dart';
import 'package:camera_cart/cart.dart';
import 'package:camera_cart/user/address/addresslist.dart';
import 'dart:typed_data';
import 'package:hive/hive.dart';
import 'package:camera_cart/Cart_db/Cart_db.dart';

import 'dart:convert';

// import 'package:projefct/user/favbutton.dart';
// import 'package:projefct/user/wishlist/wishlist_db.dart';

class Details extends StatelessWidget {
  final Uint8List? imageUrl;
  final String name;
  final String price;
  final String category;
  final String description;
  final int id;
  final String? img;

  const Details({
    Key? key,
    this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.id,
    this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imagere = img;
    final imgready = imagere != null ? base64Decode(imagere) : null;
    // final img1 = base64Decode(imagere!);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'camera cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: const [],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imageUrl != null)
            Image.memory(
              imageUrl!,
              height: 250,
              width: 500,
            )
          else if (imgready != null)
            Image.memory(
              imgready,
              height: 250,
              width: 500,
            )
          else
            Image.asset(
              'assets/placeholder_image.png', // Replace with your placeholder image path
              height: 250,
              width: 500,
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              description,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.black12,
                  ),
                  height: 40,
                  width: 380,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      final cartBox = Hive.box<CartItem>('cart');
                      cartBox.add(
                        CartItem(
                          productName: name,
                          productPrice: price,
                          imageUrl: base64Encode(imageUrl!),
                        ),
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Product added to cart'),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const CartPage(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add to Cart'),
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.black12,
                  ),
                  height: 40,
                  width: 380,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => shippingaddress(
                            totalAmount: price,
                            name: name,
                            image: imageUrl,
                          ),
                        ),
                      );
                    },
                    child: const Text('Buy Now'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
