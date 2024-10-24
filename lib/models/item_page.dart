// import 'package:coba1/models/room.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
// import '../user/home_page.dart';
// import 'package:coba1/models/item_page.dart';
//
// class ItemPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Room itemArgs = ModalRoute.of(context)?.settings.arguments as Item;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(itemArgs.name),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(itemArgs.imagePath),
//             SizedBox(height: 8.0),
//             Text(
//               '${itemArgs.name}',
//               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8.0),
//             Row(
//               children: [
//                 Text(
//                   'Price: ',
//                   style: TextStyle(fontSize: 20.0), // Font size increased to 20
//                 ),
//                 Text(
//                   'Rp ${itemArgs.price.toString()}',
//                   style: TextStyle(fontSize: 30.0),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8.0),
//             Text('Description: \n${itemArgs.description}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
