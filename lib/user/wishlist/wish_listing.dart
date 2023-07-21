// import 'package:flutter/material.dart';
// import 'package:projefct/user/favbutton.dart';
// import 'package:projefct/user/wishlist/wishlist_db.dart';
// import 'package:projefct/user/wishlist/wishlist_page.dart';

// class ListingPage extends StatelessWidget {
//   final List<WishlistItem> items;

//   ListingPage({ this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Listing Page'),
//       ),
//       body: ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];
//           return ListTile(
//             title: Text(item.name),
//             subtitle: Text(item.category!),
//             trailing: ColorChangingButton(
//                 wishlistItem: WishlistItem(
//                     name: item.name, price: item.price, image: item.image)),
//           );
//         },
//       ),
//     );
//   }
// }
