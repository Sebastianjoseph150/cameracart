
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';
import 'package:camera_cart/user/wishlist/helper_class.dart';

class ColorChangingButton extends StatefulWidget {
  final WishlistItem wishlistItem;

  const ColorChangingButton({super.key, required this.wishlistItem});

  @override
  _ColorChangingButtonState createState() => _ColorChangingButtonState();
}

class _ColorChangingButtonState extends State<ColorChangingButton> {
  bool isFavorite = false;
  late Box<WishlistItem> wishlistBox;
  WishlistHelper wishlistHelper = WishlistHelper();

  late Box<WishlistItem> _wishBox;
  List<WishlistItem> wishlist = [];
  List<WishlistItem> favorites = [];
  bool containsItem = false;

  @override
  void initState() {
    super.initState();
    _openBox();
    checkFav(widget.wishlistItem);
  }

  Future<void> deleteItem(int index) async {
    await wishlistBox.deleteAt(index);
    setState(() {
      wishlist.removeAt(index);
    });
  }

  Future<bool> checkFav(WishlistItem item) async {
    final wishBox = await Hive.openBox<WishlistItem>('wishlist');
    final wishlist = wishBox.values.toList();
    containsItem = wishlist.any((wishItem) => wishItem.id == item.id);
    print(containsItem);
    return containsItem;
  }

  Future<void> _openBox() async {
    await Hive.initFlutter();
    wishlistBox = await Hive.openBox<WishlistItem>('wishlist');
    wishlist = wishlistBox.values.toList();
  }

  Future<void> toggleFavorite() async {
    if (containsItem) {
      deleteItem(widget.wishlistItem.id);
    } else {
      await wishlistBox.add(widget.wishlistItem);
      wishlist.add(widget.wishlistItem);
    }
    setState(() {
      containsItem = !containsItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("inside build");
    print(isFavorite);
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: containsItem ? Colors.red : Colors.grey,
      ),
      onPressed: toggleFavorite,
    );
  }
}
