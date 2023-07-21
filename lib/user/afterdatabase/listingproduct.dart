// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:projefct/admindatabase/product.dart';

// class ProductGridView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: Hive.box<Product>('products').listenable(),
//       builder: (context, Box<Product> box, _) {
//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 10.0,
//             mainAxisSpacing: 10.0,
//           ),
//           itemCount: box.length,
//           itemBuilder: (context, index) {
//             final product = box.getAt(index);
//             return GridTile(
//               child: Column(
//                 children: [
//                   Image.memory(
//                     product?.image ?? [],
//                     width: 100,
//                     height: 100,
//                     fit: BoxFit.cover,
//                   ),
//                   Text('Price: ${product?.price ?? ''}'),
//                   Text('Category: ${product?.category ?? ''}'),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
