import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/components/circle_button.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  File? _image;

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
                  onPressed: _pickImage,
                  child: const Text('Pick Image'),
                ),

                // Display selected image
                if (_image != null)
                  Image.file(
                    _image!,
                    height: 100,
                  ),

                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _submitForm(
                        titleController.text,
                        fromController.text,
                        toController.text,
                        montantController.text,
                        descriptionController.text,
                        _image);
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
    File? image,
  ) async {
    try {
      String? userId;
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('yyyy/MM/dd HH:mm:ss').format(now);

      User? user = auth.currentUser;
      if (user != null) {
        userId = user.uid;
      }

      String photoUrl = await _uploadImage(image);

      await FirebaseFirestore.instance.collection('offers').add({
        'title': titre,
        'idCreateur': userId,
        'from': from,
        'to': to,
        'montant': montant,
        'photo': photoUrl,
        'date': formattedDate,
        'description': description
      });

      print('Offer added successfully');
      // You can navigate to another screen or perform additional actions here
    } catch (error) {
      print('Failed to add offer to Firebase: $error');
    }
  }

  Future<String> _uploadImage(File? image) async {
    if (image == null) {
      return Future.error("Image is null");
    }

    try {
      // Create a unique filename for the image based on the current timestamp
      String fileName = "image_${DateTime.now().millisecondsSinceEpoch}.jpg";

      // Reference to the Firebase Storage bucket
      Reference storageReference =
          FirebaseStorage.instance.ref().child("images/$fileName");

      // Upload the file to Firebase Storage
      await storageReference.putFile(image);

      // Get the download URL of the uploaded file
      String downloadURL = await storageReference.getDownloadURL();

      return downloadURL;
    } catch (error) {
      print("Error uploading image: $error");
      return Future.error("Failed to upload image");
    }
  }
}
