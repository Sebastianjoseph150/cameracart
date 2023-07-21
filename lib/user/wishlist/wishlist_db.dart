import 'package:hive_flutter/hive_flutter.dart';
part 'wishlist_db.g.dart';

@HiveType(typeId: 5)
class WishlistItem {
  @HiveField(0)
  String name;

  @HiveField(1)
  String? category;

  @HiveField(2)
  String price;

  @HiveField(3)
  String image;

  @HiveField(4)
  String? description;

  @HiveField(5)
  int id;

  // @HiveField(5)
  // String imageUrl;

  WishlistItem({
    required this.name,
    this.category,
    required this.price,
    required this.image,
    this.description,
    required this.id,
  });
}
