import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:camera_cart/Admin/dbfuntio.dart';
import 'package:camera_cart/admindatabase/product.dart';

class ProductAddingPage extends StatefulWidget {
  const ProductAddingPage({super.key});

  @override
  _ProductAddingPageState createState() => _ProductAddingPageState();
}

class _ProductAddingPageState extends State<ProductAddingPage> {
  final _formKey = GlobalKey<FormState>();
  final _productName = TextEditingController();
  late String _productCategory;
  final _productPrice = TextEditingController();
  File? _selectedImage;
  final _productdis = TextEditingController();

  List<String> categories = [
    'Nikon',
    'Sony',
    'Canon',
    'Fujifilim',
  ];

  @override
  void initState() {
    super.initState();
    _productCategory = categories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(218, 212, 212, 209),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            width: 500,
            height: 600,
            decoration: BoxDecoration(
              color: const Color.fromARGB(193, 255, 255, 255),
              border: Border.all(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _selectImage,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.add_photo_alternate,
                                size: 50,
                                color: Colors.white,
                              ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _productName,
                      decoration: const InputDecoration(
                        fillColor: Color(0xABFFFEFE),
                        labelText: 'product name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a product name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _productName.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<String>(
                      value: _productCategory,
                      decoration: const InputDecoration(
                        fillColor: Color(0xABFFFEFE),
                        labelText: 'product category',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      items: categories.map((String category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _productCategory = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _productPrice,
                      decoration: const InputDecoration(
                        fillColor: Color(0xABFFFEFE),
                        labelText: 'product price',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _productPrice.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _productdis,
                      decoration: const InputDecoration(
                        fillColor: Color(0xABFFFEFE),
                        labelText: 'product description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _productdis.text = value!;
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _addProduct();
                          Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Add Product'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _addProduct() async {
    final name = _productName.text;
    final cat = _productCategory;
    final price = _productPrice.text;
    final discrib = _productdis.text;

    final bytes = await _selectedImage!.readAsBytes();
    final String base64img = base64Encode(bytes);
    // final uuid = Uuid();
    // final placeholderId = uuid.v4();
    final details = Product(
      name: name,
      category: cat,
      price: price,
      description: discrib,
      image: base64img,
      id: -1,
    );
    _save(details);
  }

  Future<void> _save(Product value) async {
    final save = await Hive.openBox<Product>(dbname);
    final id = await save.add(value);
    final data = save.get(id);
    await save.put(
      id,
      Product(
        name: data!.name,
        category: data.category,
        price: data.price,
        description: data.description,
        image: data.image,
        id: id,
      ),
    );
    getall();
  }
}

Future<void> getall() async {
  final save = await Hive.openBox<Product>(dbname);
  productlist.value.clear();
  productlist.value.addAll(save.values);
  productlist.notifyListeners();
}
