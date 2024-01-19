import 'package:covoiturage/utils/colors.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:covoiturage/service/user_service.dart';
import 'package:covoiturage/utils/app_decoration.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  final OfferModel offer;

  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () {
          // Handle onTap event, e.g., navigate to offer details page
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Offer ID : ${offer.id}" ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        // Handle edit option
                      } else if (value == 'delete') {
                        // Handle delete option
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'From: ${offer.from}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'To: ${offer.to}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Amount: ${offer.montant}',
                style: const TextStyle(fontSize: 16),
              ),
              // Add more fields as needed
            ],
          ),
        ),
      ),
    );
  }
}
