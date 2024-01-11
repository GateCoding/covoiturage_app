import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_uploading/ImageHelper.dart';
import 'package:image_field/image_field.dart';
import 'package:image_field/linear_progress_Indicator.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:image_field/linear_progress_indicator_if.dart';

typedef Progress = Function(double percent);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  dynamic remoteFiles = <ImageAndCaptionModel>[];

  set controllerLinearProgressIndicator(
      ControllerLinearProgressIndicator?
          controllerLinearProgressIndicator) {} // Initialize as an empty list

  // Initialize the controller
  // ControllerLinearProgressIndicatorIF? controllerLinearProgressIndicator;

  Future<dynamic> uploadToServer(XFile? file,
      {Progress? uploadProgress}) async {
    // Your upload logic
    // ...

    // Simulating upload progress
    for (int i = 0; i <= 100; i += 10) {
      await Future.delayed(const Duration(seconds: 1));
      uploadProgress?.call(i.toDouble());
    }

    // Return some data after successful upload
    return 'Upload successful';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageField(),
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your form submission logic here
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
