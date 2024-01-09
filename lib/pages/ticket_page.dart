import 'package:covoiturage/components/circle_button.dart';
import 'package:covoiturage/components/colors.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/components/custom_clipper_ticket.dart';
import 'package:covoiturage/components/custom_dashed_line.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TicketPage extends StatelessWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> offerData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final OfferModel offerModel = OfferModel.fromJson(offerData);
    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 30),
              ClipPath(
                clipper: CustomClipperTicket(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Stack(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            height: 250,
                            width: double.infinity,
                            child: Image.network(
                              offerModel.photo!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              offerModel.titre!,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 16),
                            CustomPaint(
                              painter: CustomDashedLinePainter(),
                              child: const SizedBox(
                                height: 1,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textDescription("Name", "Muhammad Ridhoi"),
                                _textDescription("Date", "16 : 00 PM"),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textDescription(
                                    "Date", "${offerModel.dateCreation} 2022"),
                                _textDescription("Seat", "UNOJI B12"),
                              ],
                            ),
                            const SizedBox(height: 32),
                            CustomPaint(
                              painter: CustomDashedLinePainter(),
                              child: const SizedBox(
                                height: 1,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/images/barcode.png",
                                height: 70,
                                width: MediaQuery.of(context).size.width * 0.5,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(height: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textDescription(String title, String value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(fontSize: 12, color: AppColors.greyTextColor),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ],
      );

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Widget _buildAppBar(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleButton(
            icon: 'assets/images/ic_arrow_left.png',
            onTap: () => Navigator.pop(context),
          ),
          const Text(
            "My Ticket",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          CircleButton(icon: 'assets/images/sign-out.png', onTap: signUserOut),
          const SizedBox(width: 42),
        ],
      );
}
