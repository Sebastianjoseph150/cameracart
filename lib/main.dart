import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/Cart_db/Cart_db.dart';
import 'package:camera_cart/admindatabase/product.dart';
import 'package:camera_cart/user/address/Address_db.dart';
import 'package:camera_cart/user/user%20database/login_database.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';
import 'package:camera_cart/my_order/my_orders_db.dart';

// import 'dart:html';

import 'Splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Check if the adapter is already registered
  if (!Hive.isAdapterRegistered(ProductAdapter().typeId)) {
    // Register the ProductAdapter
    Hive.registerAdapter(ProductAdapter());
  }
  if (!Hive.isAdapterRegistered(UserAdapter().typeId)) {
    Hive.registerAdapter(UserAdapter());
  }
  if (!Hive.isAdapterRegistered(AddressAdapter().typeId)) {
    Hive.registerAdapter(AddressAdapter());
  }
  if (!Hive.isAdapterRegistered(CartItemAdapter().typeId)) {
    Hive.registerAdapter(CartItemAdapter());
  }
  if (!Hive.isAdapterRegistered(WishlistItemAdapter().typeId)) {
    Hive.registerAdapter(WishlistItemAdapter());
  }
  if (!Hive.isAdapterRegistered(OrderAdapter().typeId)) {
    Hive.registerAdapter(OrderAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(),
      ),
      home:
          const SplashScreenWidget(), // Use the splash screen as the home widget
    );
  }
}
