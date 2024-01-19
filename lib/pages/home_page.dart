import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/bloc/offer_cubit.dart';
import 'package:covoiturage/components/card_offer.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/components/my_navigation_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:covoiturage/routes/routes.dart';
import 'package:covoiturage/service/offer_service.dart';
import 'package:covoiturage/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserModel? _user;
  FirebaseAuth auth = FirebaseAuth.instance;
  List<OfferModel> filteredOffers = [];


  @override
  void initState() {
    super.initState();
    getDataUser();
  }

void _searchOffers(String fromCity, String toCity) {
    print("Searching offers for: $fromCity to $toCity");

    OfferService offerService = OfferService();
    offerService.getOffersByCities(fromCity: fromCity, toCity: toCity).listen(
      (querySnapshot) {
        print("Received query snapshot: $querySnapshot");

        setState(() {
          filteredOffers = querySnapshot.docs
              .map((doc) =>
                  OfferModel.fromJson(doc.data() as Map<String, dynamic>))
              .toList();

          print("Filtered offers: $filteredOffers");
        });
      },
    );
  }



  void getDataUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      UserService userService = UserService();
      UserModel? userModel = await userService.getUserByUid(user.uid);

      setState(() {
        _user = userModel;
      });
    }
  }


TextEditingController fromCityController = TextEditingController();
  TextEditingController toCityController = TextEditingController();

  final CollectionReference offerCollection =
      FirebaseFirestore.instance.collection('offers');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    // log ("hhhhhhhhhhhhh");
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: MyNavigationBar(
          onNavigate: (index) {
            switch (index) {
              case 0:
                Navigator.pushNamed(context, NamedRoutes.homeScreen);
                break;
              case 1:
                Navigator.pushNamed(context, NamedRoutes.addScreen);
                break;
              case 2:
                Navigator.pushNamed(context, NamedRoutes.profileScreen);
                break;
            }
          },
        ),
      ),
        body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 24),
        child: BlocProvider(
          create: (_) => OfferCubit()..listenToOffers(),
          child: Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Offers This Month",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            BlocBuilder<OfferCubit, OfferState>(
                  builder: (context, state) {
                    if (state is OfferError) {
                      return Center(child: Text(state.message));
                    } else if (state is OfferLoaded) {
                      return filteredOffers.isNotEmpty
                          ? _listOffer(filteredOffers)
                          : _listOffer(state.offers);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),

            ],
          ),
        ),
      ),
    ),
  );
  }
_buildHeader() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Covoiturage App",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Add TextField for "from" city
                Expanded(
                  child: TextField(
                    controller: fromCityController,
                    decoration: const InputDecoration(
                      labelText: "From City",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Add TextField for "to" city
                Expanded(
                  child: TextField(
                    controller: toCityController,
                    decoration: const InputDecoration(
                      labelText: "To City",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Implement search logic here
                    String fromCity = fromCityController.text;
                    String toCity = toCityController.text;
                    // Call a method to filter offers based on cities
                    _searchOffers(fromCity, toCity);
                    
                  },
                  child: const Text("Search"),
                ),
              ],
            ),
          ],
        ),
      );



  _listOffer(List<OfferModel> offers) => Container(
        height: 600,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: offers.length,
          itemBuilder: (context, index) => CardOffer(offerModel: offers[index]),
        ),
      );


}
