import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/details.dart';
import 'package:camera_cart/user/wishlist/wishlist_db.dart';

class wishlistpage extends StatefulWidget {
  const wishlistpage({Key? key}) : super(key: key);

  @override
  State<wishlistpage> createState() => _wishlistpageState();
}

class _wishlistpageState extends State<wishlistpage> {
  late Box<WishlistItem> _wishBox;
  ValueNotifier<List<WishlistItem>> wishlist = ValueNotifier([]);
  List<WishlistItem> favorites = [];

  bool isFavorite(WishlistItem item) {
    return favorites.contains(item);
  }

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    _wishBox = await Hive.openBox<WishlistItem>('wishlist');
    wishlist.value = _wishBox.values.toList();
    wishlist.notifyListeners();
  }

  Future<void> deleteItem(int index) async {
    await _wishBox.deleteAt(index);
    wishlist.value = _wishBox.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 225, 225, 225),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Wishlist'),
      ),
      body: ValueListenableBuilder(
        valueListenable: wishlist,
        builder: (context, box, _) {
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (ctx1, index) {
              final Value = box[index];

              return Padding(
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
                  child: GestureDetector(
                    child: ListTile(
                      onLongPress: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Details(
                                img: Value.image,
                                name: Value.name,
                                price: Value.price,
                                category: Value.category!,
                                description: Value.description!,
                                id: Value.id)));
                      },
                      leading: const CircleAvatar(),
                      title: Text(Value.name),
                      subtitle: Text(Value.price.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text(
                                  'Do you want to delete the product?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      deleteItem(index);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
