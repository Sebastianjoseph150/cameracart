
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/my_order/my_orders_db.dart';
import 'package:camera_cart/user/trcking/track.dart';

class MyOrderPage extends StatefulWidget {
  const MyOrderPage({super.key});

  @override
  State<MyOrderPage> createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  late Box<Order> ordersBox; // Declare a non-nullable Box variable

  @override
  void initState() {
    super.initState();
    openBox(); // Call the method to open the Hive box
  }

  Future<void> openBox() async {
    await Hive.initFlutter(); // Initialize Hive
    ordersBox = await Hive.openBox<Order>('my_orders'); // Open the Hive box
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('My Order'),
      ),
      body: FutureBuilder(
        future:
            openBox(), // Use the FutureBuilder to wait for openBox() to complete
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ValueListenableBuilder<Box<Order>>(
              valueListenable:
                  ordersBox.listenable(), // Use the ordersBox variable
              builder: (context, ordersBox, _) {
                final orderDetails =
                    getOrderDetails(ordersBox); // Retrieve the order details
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order Details:',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16.0),
                      Expanded(
                        child: ListView.builder(
                          itemCount: orderDetails.length,
                          itemBuilder: (context, index) {
                            final order = orderDetails[index];
                            // final img = order.image;
                            // final imageready = base64Decode(img);
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ProductTrackingPage(),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: const CircleAvatar(),
                                title: Text(order.productName),
                                subtitle: Text('Price: ${order.productPrice}'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            // Show a loading indicator or an empty container while waiting for openBox()
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  List<Order> getOrderDetails(Box<Order> ordersBox) {
    return ordersBox.values.toList();
  }
}
