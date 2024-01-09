import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/bloc/offer_cubit.dart';
import 'package:covoiturage/components/card_event_this_month.dart';
import 'package:covoiturage/components/colors.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/components/my_navigation_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/routes/routes.dart';
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
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
                // Handle navigation to the event screen
                break;
              case 3:
                // Handle navigation to the profile screen
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
                        "Event This Month",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<OfferCubit, OfferState>(
                  builder: (context, state) {
                    if (state is OfferError) {
                      return Center(child: Text(state.message));
                    } else if (state is OfferLoaded) {
                      return _listOfferThisMonth(state.offers);
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Current Location",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Image.asset('assets/images/ic_location.png', width: 16),
                  const SizedBox(width: 4),
                  const Text(
                    "Marrakech",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.greyTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ]),
              ],
            ),
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1609010697446-11f2155278f0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTZ8fHByb2ZpbGUlMjBwaG90b3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                ),
              ),
            )
          ],
        ),
      );

  _listOfferThisMonth(List<OfferModel> offers) => Container(
        height: 300,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: offers.length,
          reverse: true,
          itemBuilder: (context, index) => BlocBuilder<OfferCubit, OfferState>(
            builder: (context, state) {
              if (state is OfferError) {
                return const Center(child: Text("Error"));
              } else if (state is OfferLoaded) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(
                      arguments: offers[index].toJson(),
                      context,
                      NamedRoutes.detailScreen),
                  child: CardOfferThisMonth(offerModel: offers[index]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}
