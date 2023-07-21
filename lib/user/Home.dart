import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:camera_cart/admindatabase/Product_category.dart';
import 'package:camera_cart/user/details.dart';
import 'package:camera_cart/user/favbutton.dart';
import 'package:camera_cart/user/wishlist/wishlist_page.dart';

import 'package:camera_cart/user/homesub/homesub.dart';
// import 'package:projefct/user/products/product.dart';
import 'dart:typed_data';

import 'package:camera_cart/user/wishlist/wishlist_db.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  final page = [
    const Homepage(),
  ];

  final List<Widget> _screens = [
    // Add more screens here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 250, 250),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Center(child: Text('camera cart')),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((ctx) => const wishlistpage())));
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Featured Products',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
            height: 200,
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  Banner(imageUrl: 'assets/user/banner.jpg'),
                  SizedBox(
                    width: 10,
                  ),
                  Banner(imageUrl: 'assets/user/banner.jpg'),
                  SizedBox(
                    width: 10,
                  ),
                  Banner(imageUrl: 'assets/user/banner.jpg'),
                ],
              ),
            ),
          ),
          const Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                  child: Text(
                    'Popular brands',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: HorizontalListView1(),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'New Arrivals',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 500, child: UserCatListing1()),
        ],
      ),
    );
  }
}

// product card

class ProductCard extends StatelessWidget {
  final Uint8List imageUrl;
  final String name;
  final String price;
  final String category;
  final String discription;
  final int id;

  const ProductCard({
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
    return GestureDetector(
      onTap: () {
        final Imageready = base64Decode(imageUrl.toString());

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Details(
                    imageUrl: Imageready,
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
          height: 320,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColorChangingButton(
                  wishlistItem: WishlistItem(
                      name: name,
                      price: price,
                      image: imageUrl.toString(),
                      description: discription,
                      id: id)),
              Image.memory(
                imageUrl,
                height: 100,
                width: double.infinity,
              ),
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

class HorizontalListView1 extends StatelessWidget {
  const HorizontalListView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          const SizedBox(width: 10),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserCatListing2(category: 'Nikon')),
                  );
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/user/nikon-logo-CTNWXN.jpg'),
                ),
              ),
              const Text('Nikon'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserCatListing2(category: 'Canon')),
                  );
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user/images (2).png'),
                ),
              ),
              const Text('Canon'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserCatListing2(category: 'Fujifilim')),
                  );
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user/fuji.png'),
                ),
              ),
              const Text('Fujifilm'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const UserCatListing2(category: 'Sony')),
                  );
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/user/download.png'),
                ),
              ),
              const Text('Sony'),
            ],
          ),
        ],
      ),
    );
  }
}
// banner

class Banner extends StatelessWidget {
  final String imageUrl;

  const Banner({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          // Navigator.push(
          //   // context,
          //   // MaterialPageRoute(builder: (context) => Details()),
          // );
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  imageUrl,
                  height: 200,
                  width: 500, // Adjust the width of each item as needed
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
