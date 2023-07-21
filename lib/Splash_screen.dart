import 'package:flutter/material.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/admindatabase/product.dart';
import 'package:camera_cart/user/user database/login_database.dart';
import 'package:camera_cart/user/login.dart';
import 'package:camera_cart/user/address/Address_db.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera_cart/user/navigationbar/navbar.dart';
import 'package:camera_cart/Cart_db/Cart_db.dart';

class SplashScreenWidget extends StatefulWidget {
  const SplashScreenWidget({super.key});

  @override
  State<SplashScreenWidget> createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    _openHiveBoxes();
  }

  Future<void> _openHiveBoxes() async {
    await Hive.initFlutter();
    await Hive.openBox<User>('user');
    await Hive.openBox<Product>(dbname);
    await Hive.openBox<Address>('address');
    await Hive.openBox<CartItem>('cart');
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    await Future.delayed(
        const Duration(seconds: 2)); // Simulate a delay for the splash screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const MyHomePage() : const LoginForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(70, 59, 59, 59),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // FlutterLogo(size: 100),
            Image(height: 300, image: AssetImage('assets/user/cameracart.jpg')),
          ],
        ),
      ),
    );
  }
}
