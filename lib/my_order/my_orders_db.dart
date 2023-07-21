import 'package:hive/hive.dart';

part 'my_orders_db.g.dart';

@HiveType(typeId: 6)
class Order extends HiveObject {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final String productPrice;

  @HiveField(2)
  final String image;

  // Add more fields as needed

  Order(
      {required this.productName,
      required this.productPrice,
      required this.image});
}
