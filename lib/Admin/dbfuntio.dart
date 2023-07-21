import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:camera_cart/Admin/addproduct.dart';
import 'package:camera_cart/admindatabase/product.dart';

ValueNotifier<List<Product>> productlist = ValueNotifier([]);
String dbname = 'dbname';

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
          id: id));
  getall1(value);
}

Future<void> getall1(Product value) async {
  final save = await Hive.openBox<Product>(dbname);
  productlist.value.clear();
  productlist.value.addAll(save.values);
  productlist.notifyListeners();
}

Future<void> delete(int id) async {
  final remove = await Hive.openBox<Product>(dbname);
  remove.delete(id);
  getall();
}
