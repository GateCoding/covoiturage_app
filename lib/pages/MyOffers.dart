import 'package:covoiturage/bloc/offer_bloc.dart';
import 'package:covoiturage/components/widget/myoffre_card.dart';
import 'package:flutter/material.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/service/offer_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MyOffers extends StatefulWidget {
  const MyOffers({Key? key}) : super(key: key);

  @override
  _MyOffersState createState() => _MyOffersState();
}

class _MyOffersState extends State<MyOffers> {
  final OfferBloc _offerBloc = OfferBloc();

  final OfferService offerService = OfferService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String?>(
          future: _getUserName(),
          builder: (context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Text('Welcome, ${snapshot.data}!');
            } else {
              return const Text('Welcome!');
            }
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<OfferModel>>(
          future: _getUserOffers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No offers available for the current user.');
            } else {
              List<OfferModel> userOffers = snapshot.data!;
              return ListView.builder(
                itemCount: userOffers.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showOptionsDialog(userOffers[index].id!);
                    },
                    child: OfferCard(offer: userOffers[index]),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<OfferModel>> _getUserOffers() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return await offerService.getOffersByUserId(currentUser.uid);
    } else {
      return [];
    }
  }

  Future<String?> _getUserName() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      return currentUser.email;
    } else {
      return null;
    }
  }

//dialog
  void _showOptionsDialog(String offerId) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: _offerBloc,
          child: AlertDialog(
            title: const Text("Options"),
            content: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _offerBloc.add(OfferEvent.edit);
                    Navigator.pop(context);
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () {
                    _offerBloc.add(OfferEvent.delete);
                    Navigator.pop(context);
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ),
        );
      },
    );

    _offerBloc.stream.listen((event) {
      if (event == "edit") {
        _editOffer(offerId);
      } else if (event == "delete") {
        _deleteOffer(offerId);
      }
    });
  }

  //function
void _editOffer(String offerId) async {
    OfferModel? offer = await offerService.getOfferById(offerId);

    if (offer != null) {
      showDialog(
        context: context,
        builder: (context) => OfferEditDialog(offerId: offerId),
      );
    }
  }

  void _deleteOffer(String offerId) async {
    // Delete the offer using offerService
    await offerService.deleteOffer(offerId);
  }



  // Dispose the bloc when the widget is disposed
  @override
  void dispose() {
    _offerBloc.close();
    super.dispose();
  }
}




class OfferEditDialog extends StatelessWidget {
  final String offerId;

  const OfferEditDialog({Key? key, required this.offerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferBloc, String>(
      builder: (context, state) {
        return AlertDialog(
          title: const Text("Edit Offer"),
          content: const Column(
            children: [
              // Add input fields for editing offer details
              // Use TextEditingController to manage the input
              // Initialize the text fields with the current offer details
              TextField(
                  // Controller for editing offer title
                  ),
              // Add more fields as needed
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Dispatch an event to save the changes
                context.read<OfferBloc>().add(OfferEvent.edit);
              },
              child: const Text("Save"),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the dialog without saving changes
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
