import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera_cart/my_order/my_orders_db.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PaymentPage extends StatefulWidget {
  final String totalAmount;
  final name;
  final Uint8List image;
  // Total amount of the order

  const PaymentPage(
      {super.key, required this.totalAmount, required this.name, required this.image});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedPaymentIndex =
      -1; // Track the index of the selected payment option

  List<String> paymentOptions = [
    'Cash on Delivery',
    'Card',
    'UPI',
    // Add more payment options as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Payment Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Total: \$${widget.totalAmount}',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Select Payment Method',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (index == 1 || index == 2) {
                      // Show dialog for "Card" and "UPI" payment methods
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Payment Unavailable'),
                            content: const Text(
                                'This payment method is currently unavailable.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      setState(() {
                        _selectedPaymentIndex = index;
                      });
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10.0),
                      color: _selectedPaymentIndex == index
                          ? Colors.grey[200]
                          : Colors.white,
                    ),
                    child: Row(
                      children: [
                        Radio<int>(
                          value: index,
                          groupValue: _selectedPaymentIndex,
                          onChanged: (value) {
                            if (index != 1 && index != 2) {
                              setState(() {
                                _selectedPaymentIndex = value!;
                              });
                            }
                          },
                        ),
                        Expanded(
                          child: Text(
                            paymentOptions[index],
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24.0),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                onPressed: () {
                  // Handle payment method based on the selected index
                  // You can navigate to the order completion page directly
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderCompletionPage(),
                    ),
                  );
                  saveOrderDetails(
                      widget.name, widget.totalAmount, widget.image.toString());
                },
                child: const Text(
                  'Proceed to Payment',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderCompletionPage extends StatelessWidget {
  const OrderCompletionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Order Completion'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 64.0,
              color: Colors.green,
            ),
            SizedBox(height: 16.0),
            Text(
              'Order Placed Successfully!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Additional information or order summary
          ],
        ),
      ),
    );
  }
}

void saveOrderDetails(String productName, String productPrice, String image) {
  final ordersBox = Hive.box<Order>('my_orders');
  final order =
      Order(productName: productName, productPrice: productPrice, image: image);
  ordersBox.add(order);
}
