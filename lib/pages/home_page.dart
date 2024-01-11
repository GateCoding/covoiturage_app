import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/bloc/offer_cubit.dart';
import 'package:covoiturage/components/card_offer.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/components/my_navigation_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/routes/routes.dart';
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
                        "Offers This Month",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // GestureDetector(child: const CardoffrelistItemWidget())
                BlocBuilder<OfferCubit, OfferState>(
                  builder: (context, state) {
                    if (state is OfferError) {
                      return Center(child: Text(state.message));
                    } else if (state is OfferLoaded) {
                      return _listOffer(state.offers);
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Covoiturage App",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
            ClipRRect(
                borderRadius: BorderRadius.zero,
                child: Container(
                  decoration: const BoxDecoration(
                      // border: border,
                      // borderRadius: radius,
                      ),
                )),
          ],
        ),
      );

  _listOffer(List<OfferModel> offers) => Container(
        height: 600,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: offers.length,
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
                  child: CardOffer(offerModel: offers[index]),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      );
}
