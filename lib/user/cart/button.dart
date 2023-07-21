
// class QuantityButton extends StatefulWidget {
//   const QuantityButton({super.key});

//   @override
//   _QuantityButtonState createState() => _QuantityButtonState();
// }

// class _QuantityButtonState extends State<QuantityButton> {
//   int quantity = 1;

//   void incrementQuantity() {
//     setState(() {
//       quantity++;
//     });
//   }

//   void decrementQuantity() {
//     setState(() {
//       if (quantity > 1) {
//         quantity--;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 110,
//       height: 40,
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(0, 1),
//             blurRadius: 4,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           IconButton(
//             icon: const Icon(Icons.remove),
//             color: Colors.white,
//             onPressed: decrementQuantity,
//           ),
//           const SizedBox(width: 2),
//           Text(
//             quantity.toString(),
//             style: const TextStyle(fontSize: 15, color: Colors.white),
//           ),
//           const SizedBox(width: 2),
//           IconButton(
//             icon: const Icon(Icons.add),
//             color: Colors.white,
//             onPressed: incrementQuantity,
//           ),
//         ],
//       ),
//     );
//   }
// }
