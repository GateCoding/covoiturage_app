import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialog_helper/flutter_dialog_helper.dart';
import 'package:covoiturage/components/my_button.dart';
import 'package:covoiturage/components/my_textfield.dart';
import 'package:covoiturage/components/square_tile.dart';
import 'package:covoiturage/pages/toast_message.dart';
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
  final TextEditingController _imagePath = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  FocusNode focusNode = FocusNode();

  File? imageFile;

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
        final userModel = UserModel(
          email: _emailController.text,
          numberPhone: _numberPhoneController.text,
          username: _firstNameController.text,
          dateNaissance: "1990-01-01",
          imagePath: imageFile,
          uid: uid,
        );

        if (imageFile != null) {
          Reference storageReference =
              FirebaseStorage.instance.ref().child('images/');
          await storageReference.putFile(imageFile!);

          // Get the image URL
          String imageURL = await storageReference.getDownloadURL();

          // Update the Firestore document with the image URL
          //await documentReference.update({'imageURL': imageURL});
        }

        print('Event added to Firebase');
        // You can navigate to another screen or perform additional actions here

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

  Future<void> _pickImage() async {
    //controller:_imagePath;
    try {
      final ImagePicker imagePicker = ImagePicker();

      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);
      print("${imagePicker}ddddddddddd");

      if (image != null) {
        setState(() {
          imageFile = File(image.path);
          print("${imageFile}ddddddddddd22222222222");
        });
      }
    } catch (e) {
      print("Error selecting image: $e");
    }
  }

  Future<void> addUserToFirestore(UserModel userModel) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.uid)
          .set(userModel.toJson());
    } catch (e) {
      print('Error adding user to Firestore: $e');
    }
  }

  void UploadImageft() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 50),
                Text(
                  'Let\'s create an account for you!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_a_photo),
                  // controller:_imagePath,
                  onPressed: () {
                    _pickImage();
                    print("ddddddddddd");
                  },
                ),
                // Display selected image if available
                imageFile != null
                    ? Image.file(
                        imageFile!,
                        height: 100,
                        width: 100,
                      )
                    : Container(),
                const SizedBox(height: 25),
                MyTextField(
                  controller: _firstNameController,
                  hintText: 'username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                IntlPhoneField(
                  controller: _numberPhoneController,
                  focusNode: focusNode,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
                  },
                ),
                MyTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 25),
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
