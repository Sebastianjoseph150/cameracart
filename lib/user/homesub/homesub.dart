import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/Admin/addproduct.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';
import 'package:camera_cart/admindatabase/product.dart';
import 'dart:typed_data';

import 'package:camera_cart/user/details.dart';

import 'dart:convert';

import 'package:camera_cart/user/favbutton.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';

class UserCatListing1 extends StatefulWidget {
  const UserCatListing1({super.key});

  @override
  _UserCatListing1State createState() => _UserCatListing1State();
}

class _UserCatListing1State extends State<UserCatListing1> {
  late Box<Product> _productBox = Hive.box<Product>('products');

  @override
  void initState() {
    super.initState();
    _openBox();
    getall();
  }

  Future<void> _openBox() async {
    _productBox = await Hive.openBox<Product>('products');
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: productlist,
      builder: (context, List<Product> adminlist, Widget? child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
            childAspectRatio: 0.75,
          ),
          itemCount: adminlist.length,
          itemBuilder: (context, index) {
            final product = adminlist[index];
            final img = product.image;
            final imagere = product.image.toString();

            final imageData = img != null ? base64Decode(img) : Uint8List(0);
            return ProductCard1(
              imageUrl: imageData,
              name: product.name,
              price: product.price,
              discription: product.description,
              category: product.category,
              id: product.id,
            );
          },
        );
      },
    );
  }

  void _navigateToAddPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductAddingPage()),
    );
  }
}

// class UserCatListing1 extends StatefulWidget {
//   const UserCatListing1({super.key});

//   @override
//   _UserCatListing1State createState() => _UserCatListing1State();
// }

// class _UserCatListing1State extends State<UserCatListing1> {
//   late Box<Product> _productBox = Hive.box<Product>('products');

//   @override
//   void initState() {
//     super.initState();
//     _openBox();
//     getall();
//   }

//   Future<void> _openBox() async {
//     _productBox = await Hive.openBox<Product>('products');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: productlist,
//       builder: (context, List<Product> adminlist, Widget? child) {
//         if (_productBox.isEmpty) {
//           return Center(
//             child: Text(
//               'No products',
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//           );
//         }

//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
//             childAspectRatio: 0.75,
//           ),
//           itemCount: adminlist.length,
//           itemBuilder: (context, index) {
//             final product = adminlist[index];
//             final img = product.image;
//             final imagere = product.image.toString();

//             final imageData = img != null ? base64Decode(img) : Uint8List(0);
//             return ProductCard1(
//               imageUrl: imageData,
//               name: product.name,
//               price: product.price,
//               discription: product.description,
//               category: product.category,
//               id: product.id,
//             );
//           },
//         );
//       },
//     );
//   }

//   void _navigateToAddPage() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const ProductAddingPage()),
//     );
//   }
// }

class ProductCard1 extends StatelessWidget {
  final Uint8List imageUrl;
  final String name;
  final String price;
  final String discription;
  final String category;
  final int id;

  const ProductCard1({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
    required this.discription,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrlString = base64Encode(imageUrl);

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
            ),
          ),
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
                  name: name,
                  price: price,
                  image: imageUrlString,
                  category: category,
                  description: discription,
                  id: id,
                ),
              ),
              if (imageUrl != null)
                Image.memory(
                  imageUrl,
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
