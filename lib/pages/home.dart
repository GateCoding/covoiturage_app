import 'package:flutter/material.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/model/offre_list_model.dart';
// import 'package:covoiturage/service/offer_service.dart'; // Import your OfferModel

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CardCarousel(),
    );
  }
}

class CardCarousel extends StatefulWidget {
  const CardCarousel({Key? key}) : super(key: key);

  @override
  _CardCarouselState createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  late List<OfferListModel> offers;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchOffers();
  }

  Future<void> fetchOffers() async {
    // final data = await OfferService.getData();
    // setState(() {
    //   offers = data.cast<OfferListModel>();
    // });
  }

  void _handleAccept() {
    _moveToNextCard();
  }

  void _handleRefuse() {
    _moveToNextCard();
  }

  void _moveToNextCard() {
    setState(() {
      currentIndex = (currentIndex + 1).clamp(0, offers.length - 1);
    });
  }

  void _moveToPreviousCard() {
    setState(() {
      currentIndex = (currentIndex - 1).clamp(0, offers.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (offers.isEmpty) {
      return const Center(
        child: Text('No offers available.'),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 500.0,
          child: Card(
            margin: const EdgeInsets.all(16.0),
            color: Colors.lightBlue[100],
            child: Column(
              children: [
                ListTile(
                  title: Text(offers[currentIndex].titre ?? ''),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Description: ${offers[currentIndex].description ?? ''}'),
                      Text('Start Date: ${offers[currentIndex].dateDebut ?? ''}'),
                      Text('End Date: ${offers[currentIndex].dateFin ?? ''}'),
                      Text('Amount: ${offers[currentIndex].montant ?? ''}'),
                    ],
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _handleAccept,
                      child: const Text('Accept'),
                    ),
                    ElevatedButton(
                      onPressed: _handleRefuse,
                      child: const Text('Refuse'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _moveToPreviousCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Previous'),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              onPressed: _moveToNextCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}