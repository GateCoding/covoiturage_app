import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/components/circle_button.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key});

  @override
  _AddOfferPageState createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  OfferModel? offer; // Create an instance of EventModel
  final TextEditingController titleController = TextEditingController();
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController montantController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Offer Title'),
                ),
                const SizedBox(height: 16.0),
                // TextField(
                //   controller: dateController,
                //   decoration: const InputDecoration(labelText: 'Offer Date'),
                //   onTap: () async {
                //     DateTime? pickedDate = await showDatePicker(
                //       context: context,
                //       initialDate: DateTime.now(),
                //       firstDate: DateTime.now(),
                //       lastDate: DateTime(2101),
                //     );

                //     if (pickedDate != null) {
                //       String formattedDate =
                //           DateFormat('dd MMM').format(pickedDate);
                //       dateController.text = formattedDate;
                //     }
                //   },
                // ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: fromController,
                  decoration: const InputDecoration(labelText: 'From'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: toController,
                  decoration: const InputDecoration(labelText: 'From'),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: montantController,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(
                        titleController.text,
                        fromController.text,
                        toController.text,
                        descriptionController.text,
                        montantController.text);
                  },
                  child: const Text('Add offer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Widget _buildAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            icon: 'assets/images/ic_arrow_left.png',
            onTap: () => Navigator.pop(context),
          ),
          const Text(
            "Detail",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          CircleButton(icon: 'assets/images/sign-out.png', onTap: signUserOut)
        ],
      );

  void _submitForm(
    String titre,
    String from,
    String to,
    String montant,
    String description,
  ) async {
    try {
      late String userId; // Declare userId as late

      User? user = auth.currentUser;
      if (user != null) {
        userId = user.uid;
      }

      DocumentReference documentReference =
          await FirebaseFirestore.instance.collection('offers').add({
        'title': titre,
        'idCreateur': userId,
        'from': from,
        'to': to,
        'montant': montant,
        'photo':
            "https://img.freepik.com/free-photo/closeup-chinese-paper-lantern-with-lights-surrounded-by-buildings_181624-13712.jpg?w=996&t=st=1662381267~exp=1662381867~hmac=fdf7b5d904279e2cb8d3a43ae0f2ddd0ad623addc5408a8578eb0ae2fb8c9187",
        'date': DateTime.now(),
        'description': description
      });

      print('Offer added to Firebase');
      // You can navigate to another screen or perform additional actions here
    } catch (error) {
      print('Failed to add offer to Firebase: $error');
    }
  }
}
