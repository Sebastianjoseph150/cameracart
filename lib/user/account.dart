// import 'package:flutter/material.dart';
// import 'package:projefct/user/address/Address_edit.dart';
// import 'package:projefct/user/login.dart';
// import 'package:projefct/user/trcking/track.dart';
// import 'package:projefct/Admin/adminlogin.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:projefct/user/wishlist/wishlist_page.dart';
// import 'package:projefct/my_order/my_order.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:projefct/user/user database/login_database.dart';

// class AdditionalInformation extends StatefulWidget {
//   const AdditionalInformation({super.key});

//   // const AdditionalInformation({super.key, required this.title});

//   // final String title;

//   @override
//   State<AdditionalInformation> createState() => _MyHomePageState();
//   Future<void> getuser() async {
//     await Hive.openBox<User>('users'); // Open the Hive box for users

//     final usersBox = Hive.box<User>('users');
//   }
// }

// class _MyHomePageState extends State<AdditionalInformation> {
//   bool isSwitched = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: const Center(
//           child: Text(
//             'Account',
//             style: TextStyle(color: Colors.black),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.favorite,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.of(context)
//                   .push(MaterialPageRoute(builder: ((ctx) => wishlistpage())));
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: Center(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const CircleAvatar(
//                   radius: 60, // Adjust the radius as needed
//                   backgroundImage: AssetImage(
//                       'assets/images/avatar.png'), // Replace with your own image path
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 const Text(
//                   'sebastian joseph',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 const Text(
//                   '+918157966506',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ListView(
//                   shrinkWrap: true,
//                   children: [
//                     // ListTile(
//                     //   leading: const Icon(Icons.person, color: Colors.black),
//                     //   title: const Text(
//                     //     'Edit profile',
//                     //     style: TextStyle(
//                     //       fontSize: 20,
//                     //       color: Colors.black,
//                     //     ),
//                     //   ),
//                     //   trailing: const Icon(Icons.arrow_forward_ios,
//                     //       size: 20, color: Colors.black),
//                     //   onTap: () {
//                     //     // Handle onTap action
//                     //   },
//                     // ),
//                     ListTile(
//                       leading:
//                           const Icon(Icons.location_city, color: Colors.black),
//                       title: const Text(
//                         'Address',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => shippingaddress1()),
//                         );
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.notification_add,
//                           color: Colors.black),
//                       title: const Text(
//                         'Admin',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const Login1()),
//                         );
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.shield, color: Colors.black),
//                       title: const Text(
//                         'Privcay policy',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black),
//                       onTap: () {
//                         // Handle onTap action
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.book, color: Colors.black),
//                       title: const Text(
//                         'Terms & conditons',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black54),
//                       onTap: () {
//                         // Handle onTap action
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.add_box, color: Colors.black),
//                       title: const Text(
//                         'My orders',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.black,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MyOrderPage()),
//                         );
//                       },
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.logout, color: Colors.red),
//                       title: const Text(
//                         'Log out',
//                         style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.red,
//                         ),
//                       ),
//                       trailing: const Icon(Icons.arrow_forward_ios,
//                           size: 20, color: Colors.black),
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: const Text('Log out'),
//                               content: const Text(
//                                   'Are you sure you want to log out?'),
//                               actions: [
//                                 TextButton(
//                                   child: const Text('Cancel'),
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                                 TextButton(
//                                   child: const Text('Log out'),
//                                   onPressed: () async {
//                                     SharedPreferences prefs =
//                                         await SharedPreferences.getInstance();
//                                     await prefs
//                                         .clear(); // Clear all stored data in SharedPreferences
//                                     Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const LoginForm(),
//                                       ),
//                                       (route) => false,
//                                     );

//                                     // You can also navigate to the login screen or perform any other actions
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:camera_cart/user/address/Address_edit.dart';
import 'package:camera_cart/user/login.dart';
import 'package:camera_cart/Admin/adminlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera_cart/user/wishlist/wishlist_page.dart';
import 'package:camera_cart/my_order/my_order.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:camera_cart/user/user database/login_database.dart';
import 'package:camera_cart/my_order/my_orders_db.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({super.key});

  @override
  State<AdditionalInformation> createState() => _MyHomePageState();
  Future<void> getuser() async {
    await Hive.openBox<User>('users'); // Open the Hive box for users

    final usersBox = Hive.box<User>('users');
  }
}

class _MyHomePageState extends State<AdditionalInformation> {
  Box<Order>? ordersBox; // Declare a Box variable
  User? user; // Declare a User variable

  @override
  void initState() {
    super.initState();
    openBox(); // Call the method to open the Hive box
    getUserData(); // Call the method to get user data
  }

  Future<void> openBox() async {
    try {
      await Hive.initFlutter(); // Initialize Hive
      await Hive.openBox<Order>('my_orders'); // Open the Hive box
      ordersBox =
          Hive.box<Order>('my_orders'); // Assign the box to the variable
    } catch (e) {
      // Handle any exceptions
      print('Error opening Hive box: $e');
    }
  }

  Future<void> getUserData() async {
    final usersBox = await Hive.openBox<User>('users');
    user = usersBox.get(0); // Retrieve the user data
    setState(() {}); // Update the state to reflect the changes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Center(
          child: Text(
            'Account',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: ((ctx) => const wishlistpage())));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const CircleAvatar(
                  radius: 60, // Adjust the radius as needed
                  backgroundImage: AssetImage(
                      'assets/user/images.jpeg'), // Replace with your own image path
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user?.number ?? '',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    // ListTile(
                    //   leading: const Icon(Icons.person, color: Colors.black),
                    //   title: const Text(
                    //     'Edit profile',
                    //     style: TextStyle(
                    //       fontSize: 20,
                    //       color: Colors.black,
                    //     ),
                    //   ),
                    //   trailing: const Icon(Icons.arrow_forward_ios,
                    //       size: 20, color: Colors.black),
                    //   onTap: () {
                    //     // Handle onTap action
                    //   },
                    // ),
                    ListTile(
                      leading:
                          const Icon(Icons.location_city, color: Colors.black),
                      title: const Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const shippingaddress1()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notification_add,
                          color: Colors.black),
                      title: const Text(
                        'Admin',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login1()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.shield, color: Colors.black),
                      title: const Text(
                        'Privcay policy',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.book, color: Colors.black),
                      title: const Text(
                        'Terms & conditons',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black54),
                      onTap: () {
                        // Handle onTap action
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.add_box, color: Colors.black),
                      title: const Text(
                        'My orders',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyOrderPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        'Log out',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.red,
                        ),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          size: 20, color: Colors.black),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Log out'),
                              content: const Text(
                                  'Are you sure you want to log out?'),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text('Log out'),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs
                                        .clear(); // Clear all stored data in SharedPreferences
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const LoginForm(),
                                      ),
                                      (route) => false,
                                    );

                                    // You can also navigate to the login screen or perform any other actions
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
