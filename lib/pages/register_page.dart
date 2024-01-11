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

  String? imageFile;

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
          await storageReference.putFile(imageFile! as File);

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
          imageFile = File(image.path) as String?;
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
 

 // ... (Previous code remains unchanged)
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
        actions: <Widget>[
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              margin: const EdgeInsets.all(10),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.add_a_photo),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
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
                            child: imageFile != null
                                ? ClipOval(
                                    child: Image.file(
                                      imageFile! as File,
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
                  ),                  languageCode: "en",
                  onChanged: (phone) {
                    print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    print('Country changed to: ${country.name}');
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
                  ),                ),
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
                    labelText:  'Confirm Password',
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
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 18.0),
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
 }
