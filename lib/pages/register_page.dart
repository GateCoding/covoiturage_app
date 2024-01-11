import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_helper/flutter_dialog_helper.dart';
import 'package:covoiturage/utils/toast_message.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl_phone_field/intl_phone_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _numberPhoneController = TextEditingController();
  FocusNode focusNode = FocusNode();
  File? _image;

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (_passwordController.text == _confirmPasswordController.text) {
        final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        String? uid = res.user?.uid;
        String photoUrl = await _uploadImage(_image);
        final userModel = UserModel(
          email: _emailController.text,
          numberPhone: _numberPhoneController.text,
          username: _firstNameController.text,
          dateNaissance: "1990-01-01",
          imagePath: photoUrl,
          uid: uid,
        );

        ToastMsg.showToastMsg('Event added successfully');

        await addUserToFirestore(userModel);

        try {
          ToastMsg.showToastMsg("Registered");
          Navigator.pop(context);
        } catch (e) {
          ToastMsg.showToastMsg("Something went wrong");
        }
      } else {
        showErrorMessage(context, "Passwords don't match!!!");
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text('INCORRECT EMAIL'),
          ),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Center(
            child: Text('INCORRECT PASSWORD'),
          ),
        );
      },
    );
  }

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
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: _pickImage,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            child: _image != null
                                ? ClipOval(
                                    child: Image.file(
                                      _image!,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(),
                          ),
                          const Icon(
                            Icons.add,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _firstNameController,
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: signUserUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0XFF08B783),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Sign Up',
                        style:
                            TextStyle(fontSize: 18.0, color: Color(0XFFFFFFFF)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
}
