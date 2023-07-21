import 'package:hive/hive.dart';

part 'Cart_db.g.dart';

@HiveType(typeId: 4)
class CartItem extends HiveObject {
  @HiveField(0)
  String productName;

  @HiveField(1)
  String productPrice;

  @HiveField(2)
  String? imageUrl;
  @HiveField(3)
  double? quantity;
  @HiveField(4)
  int? id;

  CartItem(
      {required this.productName,
      required this.productPrice,
      required this.imageUrl,
      this.quantity,
      this.id});
}
