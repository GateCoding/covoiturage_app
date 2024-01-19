import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/components/toast_message.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:covoiturage/routes/routes.dart';
import 'package:covoiturage/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FirebaseAuth auth = FirebaseAuth.instance;
  File? _image;

  Future<void> addUserToFirestore(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());
    } catch (e) {
      ToastMsg.showToastMsg('Error adding user to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => SettingsPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child:
                    // Stack(
                    //   children: [
                    //     Container(
                    //       width: 130,
                    //       height: 130,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(
                    //           width: 4,
                    //           color: Theme.of(context).scaffoldBackgroundColor,
                    //         ),
                    //         boxShadow: [
                    //           BoxShadow(
                    //             spreadRadius: 2,
                    //             blurRadius: 10,
                    //             color: Colors.black.withOpacity(0.1),
                    //             offset: const Offset(0, 10),
                    //           )
                    //         ],
                    //         shape: BoxShape.circle,
                    //         image: const DecorationImage(
                    //           fit: BoxFit.cover,
                    //           image: NetworkImage(
                    //             "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: 0,
                    //       right: 0,
                    //       child: Container(
                    //         height: 40,
                    //         width: 40,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           border: Border.all(
                    //             width: 4,
                    //             color: Theme.of(context).scaffoldBackgroundColor,
                    //           ),
                    //           color: Colors.green,
                    //         ),
                    //         child: const Icon(
                    //           Icons.edit,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          )
                        ],
                        shape: BoxShape.circle,
                        image: _image != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_image!),
                              )
                            : const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              IntlPhoneField(
                controller: _numberPhoneController,
                focusNode: focusNode,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                languageCode: "en",
              ),
              TextField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Event Date'),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    _dateController.text = formattedDate;
                  }
                },
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _submitForm(
                          _userNameController.text,
                          _dateController.text,
                          _emailController.text,
                          _numberPhoneController.text,
                          _image);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your logic here for the SAVE button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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

  Future<String> _uploadImage(File? image) async {
    if (image == null) {
      return Future.error("Image is null");
    }

    try {
      String fileName = "image_${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference storageReference =
          FirebaseStorage.instance.ref().child("images_user/$fileName");
      await storageReference.putFile(image);
      String downloadURL = await storageReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      ToastMsg.showToastMsg("Error uploading image: $error");
      return Future.error("Failed to upload image");
    }
  }

  void _submitForm(String username, String dateNaissance, String email,
      String numberPhone, File? image) async {
    try {
      String? userId;
      User? user = auth.currentUser;
      if (user != null) {
        userId = user.uid;
      }

      String photoUrl = await _uploadImage(image);

      UserService userService = UserService();
      await userService.updateUserByUid(
          userId!,
          UserModel(
              username: username,
              numberPhone: numberPhone,
              email: email,
              dateNaissance: dateNaissance,
              imagePath: photoUrl));

      ToastMsg.showToastMsg('Offer added successfully');
      Navigator.pushNamed(context, NamedRoutes.profileScreen);
      // You can navigate to another screen or perform additional actions here
    } catch (error) {
      ToastMsg.showToastMsg('Failed to add offer to Firebase: $error');
    }
  }
}
