import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/address/Address_db.dart';

class Myaddress extends StatefulWidget {
  const Myaddress({Key? key}) : super(key: key);

  @override
  State<Myaddress> createState() => _MyaddressState();
}

class _MyaddressState extends State<Myaddress> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _addressLineController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(child: Text('Add Address')),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xABFFFEFE),
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addressLineController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xABFFFEFE),
                      labelText: 'Address Line',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Address Line';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xABFFFEFE),
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter City';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xABFFFEFE),
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter State';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(
                      fillColor: Color(0xABFFFEFE),
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Postal Code';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, perform desired action
                          String name = _nameController.text;
                          String addressLine = _addressLineController.text;
                          String city = _cityController.text;
                          String state = _stateController.text;
                          String postalCode = _postalCodeController.text;
                          // Create an instance of the Address model
                          Address address = Address(
                            name: name,
                            Addressline1: addressLine,
                            Addressline2: city,
                            state: state,
                            pin: postalCode,
                          );
                          // Add the address to the database
                          _addAddress(address);
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _addAddress(Address address) async {
  final addressBox = await Hive.openBox<Address>('address');
  addressBox.add(address);

  // Navigator.pop(context);
}
