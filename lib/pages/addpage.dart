import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:covoiturage/config.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddOfferPage extends StatefulWidget {
  const AddOfferPage({super.key});

  @override
  _AddOfferPageState createState() => _AddOfferPageState();
}

class _AddOfferPageState extends State<AddOfferPage> {
  final _formKey = GlobalKey<FormState>();
  OfferModel offer = OfferModel(); // Create an instance of OfferModel

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Offer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Title'),
                  initialValue: 'TEST Offer',
                  onSaved: (value) => offer.titre = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Description'),
                  initialValue: 'This is a sample offer description.',
                  maxLines: 5,
                  onSaved: (value) => offer.description = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Address'),
                  initialValue: 'hyujytj',
                  onSaved: (value) => offer.adresse = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an address';
                    }
                    return null;
                  },
                ),

                TextFormField(
                  decoration: const InputDecoration(labelText: 'Amount'),
                  initialValue: '100.0',
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      offer.montant = double.parse(value!) as int?,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                ),
                FormBuilderTextField(
                  name: 'id',
                  decoration: const InputDecoration(labelText: 'ID'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    offer.id = int.parse(value!);
                  },
                ),

                FormBuilderTextField(
                  name: 'id_createur',
                  decoration: const InputDecoration(labelText: 'Creator ID'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    offer.idCreateur = int.parse(value!);
                  },
                ),

                FormBuilderTextField(
                  name: 'photo',
                  decoration: const InputDecoration(labelText: 'Photo URL'),
                  onSaved: (value) {
                    offer.photo = value!;
                  },
                ),
                FormBuilderCheckbox(
                  name: 'status',
                  initialValue: false, // Set default value as needed
                  title: const Text('Status'),
                  onChanged: (value) {
                    offer.status = value;
                  },
                ),

                FormBuilderDateTimePicker(
                  name: 'dateCreation',
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: 'Creation Date'),
                  initialDate: DateTime.now(),
                  initialValue: DateTime.now(),
                  format: DateFormat('yyyy-MM-dd HH:mm'),
                  onChanged: (value) {
                    // Handle onChanged if needed
                  },
                  onSaved: (value) {
                    offer.dateCreation = value;
                  },
                ),

                FormBuilderDateTimePicker(
                  name: 'dateDebut',
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: 'Debut Date'),
                  initialDate: DateTime.now(),
                  initialValue: DateTime.now(),
                  format: DateFormat('yyyy-MM-dd HH:mm'),
                  onChanged: (value) {
                    // Handle onChanged if needed
                  },
                  onSaved: (value) {
                    offer.dateDebut = value;
                  },
                ),

                FormBuilderDateTimePicker(
                  name: 'dateFin',
                  inputType: InputType.both,
                  decoration: const InputDecoration(labelText: 'Fin Date'),
                  initialDate: DateTime.now(),
                  initialValue: DateTime.now(),
                  format: DateFormat('yyyy-MM-dd HH:mm'),
                  onChanged: (value) {
                    // Handle onChanged if needed
                  },
                  onSaved: (value) {
                    offer.dateFin = value;
                  },
                ),

                // Add other TextFormFields for each field in OfferModel

                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  child: const Text('Add Offer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();

    //   try {
    //     // Convert the offer object to a JSON-encoded string
    //     final offerJson = jsonEncode(offer.toJson());
    //     final apiUrl = "$apiUrlOffer/offer/save"; // Replace with your actual API endpoint

    //     // Make a POST request to your API
    //     final response = await http.post(
    //       Uri.parse(apiUrl),
    //       headers: {'Content-Type': 'application/json'},
    //       body: offerJson,
    //     );

    //     if (response.statusCode == 200) {
    //       // Offer saved successfully
    //       print('Offer saved successfully!');
    //       // You can navigate back, show a success message, or perform other actions here
    //     } else {
    //       // Failed to save offer
    //       print('Failed to save offer. Status code: ${response.statusCode}');
    //       // You can handle errors, show an error message, or perform other actions here
    //     }
    //   } catch (error) {
    //     // Handle other errors, show an error message, or perform other actions here
    //     print('Error submitting form: $error');
    //   }
    // }
  }
}
