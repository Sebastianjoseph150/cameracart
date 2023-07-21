
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/address/address.dart';
import 'Address_db.dart';

class shippingaddress1 extends StatefulWidget {
  const shippingaddress1({
    Key? key,
  }) : super(key: key);

  @override
  State<shippingaddress1> createState() => _shippingaddress1State();
}

class _shippingaddress1State extends State<shippingaddress1> {
  late Box<Address> _addressBox =
      Hive.box<Address>('address'); // Declare the Hive box variable
  int _selectedAddressIndex = -1; // Track the index of the selected address

  @override
  void initState() {
    super.initState();
    _openAddressBox(); // Open the Hive box during initialization
  }

  void _openAddressBox() async {
    _addressBox = await Hive.openBox<Address>('address');
  }

  void _deleteAddress(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Address'),
          content: const Text('Are you sure you want to delete this address?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addressBox.deleteAt(index); // Delete address from the box
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
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
        title: const Text('Shipping Address'),
      ),
      body: ValueListenableBuilder(
        valueListenable:
            _addressBox.listenable(), // Use the addressBox variable
        builder: (context, Box<Address> addressBox, _) {
          final addresses = addressBox.values.toList();

          return ListView.builder(
            itemCount: addresses.length,
            itemBuilder: (context, index) {
              final address = addresses[index];
              return GestureDetector(
                onLongPress: () {
                  _deleteAddress(index);
                },
                child: Padding(
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
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                      ),
                      title: Text(address.name),
                      subtitle: Text(
                        '${address.Addressline1}, ${address.Addressline2}, ${address.pin}, ${address.state}',
                      ),
                      trailing: Radio<int>(
                        value: index,
                        groupValue: _selectedAddressIndex,
                        onChanged: (value) {
                          setState(() {
                            _selectedAddressIndex = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 350,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors
                            .black; // Change to desired color when pressed
                      }
                      return Colors.black; // Default button color
                    },
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Myaddress()),
                  );
                },
                child: const Text("Add new Address"),
              ),
            ),
            const SizedBox(
              width: 350,
            ),
          ],
        ),
      ),
    );
  }
}
