import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';

class WishlistHelper {
  Box<WishlistItem>? wishlistBox;

  Future<void> openBox() async {
    await Hive.initFlutter();
    wishlistBox = await Hive.openBox<WishlistItem>('wishlist');
  }

  bool isFavorite(WishlistItem item) {
    final Box<WishlistItem> wishlistBox = Hive.box<WishlistItem>('wishlist');

    return wishlistBox.values.contains(item);

    return false;
  }
}
