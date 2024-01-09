import 'package:covoiturage/components/colors.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:flutter/material.dart';

class CardOfferThisMonth extends StatelessWidget {
  final OfferModel offerModel;

  const CardOfferThisMonth({required this.offerModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              offerModel.photo!,
              fit: BoxFit.cover,
              width: 60,
              height: double.infinity,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                offerModel.titre!,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Image.asset('assets/images/ic_location.png', width: 14),
                  const SizedBox(width: 8),
                  Text(
                    offerModel.from!,
                    style: const TextStyle(
                      fontSize: 19,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    offerModel.to!,
                    style: const TextStyle(
                      fontSize: 19,
                      color: AppColors.greyTextColor,
                    ),
                  )
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 50,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.primaryLightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  offerModel.dateCreation! as String,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
