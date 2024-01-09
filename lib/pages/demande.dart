// // ignore_for_file: prefer_const_literals_to_create_immutables

// import 'package:covoiturage/service/database.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Entite extends StatefulWidget {
//   const Entite({super.key});

//   @override
//   State<Entite> createState() => _EntiteState();
// }

// class _EntiteState extends State<Entite> {
//   TextEditingController filed1controller = TextEditingController();
//   TextEditingController filed2controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Row(
//           children: [
//             Text(
//               "Entity",
//               style: TextStyle(
//                   color: Colors.blue,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "From",
//               style: TextStyle(
//                   color: Colors.orange,
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//           margin: const EdgeInsets.only(left: 20, top: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               //1
//               const Text(
//                 "Filed1",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: TextField(
//                   controller: filed1controller,
//                   decoration: const InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               const Text(
//                 "Filed2",
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 padding: const EdgeInsets.only(left: 10),
//                 decoration: BoxDecoration(
//                     border: Border.all(),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: TextField(
//                   controller: filed2controller,
//                   decoration: const InputDecoration(border: InputBorder.none),
//                 ),
//               ),
//               const SizedBox(
//                 height: 30.0,
//               ), // SizedBox

//               Center(
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // String Id = randomAlphaNumeric(10);
//                     Map<String, dynamic> entityInfoMap = {
//                       "Filed1": filed1controller
//                           .text, // Use .text to get the text from the controller
//                       "Filed2": filed2controller
//                           .text, // Use .text to get the text from the controller
//                       // "Id": Id,
//                     };
//                     await DatabaseMethods()
//                         .addEntityDetails(entityInfoMap)
//                         .then(
//                           (value) => Fluttertoast.showToast(
//                             msg: "The entity has been created",
//                             toastLength: Toast.LENGTH_SHORT,
//                             gravity: ToastGravity.CENTER,
//                             timeInSecForIosWeb: 1,
//                             backgroundColor: Colors.red,
//                             textColor: Colors.white,
//                             fontSize: 16.0,
//                           ),
//                         );
//                   },
//                   child: const Text(
//                     "Add",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )),
//     );
//   }
// }
