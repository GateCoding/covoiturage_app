import 'dart:developer';

import 'package:covoiturage/components/circle_button.dart';
import 'package:covoiturage/components/custom_app_bar.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:covoiturage/service/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  OfferModel? offerModel;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userModel;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void getDataUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      UserService userService = UserService();
      UserModel? userModel = await userService.getUserByUid(user.uid);

      setState(() {
        userModel = userModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> offerData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    offerModel = OfferModel.fromJson(offerData);

    return Scaffold(
      appBar:
          const PreferredSize(preferredSize: Size(0, 0), child: CustomAppBar()),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
                child: Column(
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 24),
                    _buildCardImage(offerModel!),
                    const SizedBox(height: 16),
                    _buildDescription(offerModel!),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildBottomBar(context, offerModel!),
          )
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, OfferModel offerModel) =>
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 34, vertical: 16),
          decoration: const BoxDecoration(color: Color(0xFFffffff)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Total Price",
                    style: TextStyle(fontSize: 12, color: Color(0xFF9698A9)),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        "${offerModel.montant}DH",
                        style: const TextStyle(
                          color: Color(0XFF08B783),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        "/Person",
                        style:
                            TextStyle(fontSize: 12, color: Color(0xFF9698A9)),
                      )
                    ],
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  var req = BraintreeDropInRequest(
                    tokenizationKey: 'sandbox_g42y39zw_348pk9cgf3bgyw2b',
                    collectDeviceData: true,
                    paypalRequest: BraintreePayPalRequest(
                        amount: offerModel.montant,
                        displayName: userModel?.username),
                    cardEnabled: true,
                  );
                  BraintreeDropInResult? res = await BraintreeDropIn.start(req);
                  log(res!.paymentMethodNonce.description);
                  log(res.paymentMethodNonce.nonce);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0XFF08B783),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    maximumSize: const Size(200, 150)),
                child: const Text(
                  "Get this offer",
                  style: TextStyle(color: Color(0xFFffffff), fontSize: 16),
                ),
              )
            ],
          ),
        ),
      );

  Widget _buildCardImage(OfferModel offerModel) => Stack(
        children: [
          Container(
            width: double.infinity,
            height: 280,
            decoration: BoxDecoration(
                color: const Color(0xFFffffff),
                borderRadius: BorderRadius.circular(16)),
          ),
          Container(
            width: double.infinity,
            height: 310,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  offerModel.photo!,
                ),
              ),
            ),
          ),
          Positioned(
            right: 22,
            top: 22,
            child: Container(
              height: 65,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFffffff),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    offerModel.dateStart!,
                    style: const TextStyle(
                      color: Color(0XFF08B783),
                    ),
                  ),
                ],
              ),
            ),
          )
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
            "Offer Detail",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          CircleButton(icon: 'assets/images/sign-out.png', onTap: signUserOut)
        ],
      );

  _buildDescription(OfferModel offerModel) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offerModel.titre!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Trajet",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/ic_location.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "From ${offerModel.from!}",
                          style: const TextStyle(
                              fontSize: 18, color: Color(0xFF9698A9)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          " To ${offerModel.to!}",
                          style: const TextStyle(
                              fontSize: 18, color: Color(0xFF9698A9)),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 65,
                  height: 35,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0XFF08B783),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "${offerModel.montant}DH",
                    style: const TextStyle(
                      color: Color(0XFFFFFFFF),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            // const StackParticipant(
            //   fontSize: 14,
            //   width: 30,
            //   height: 30,
            //   positionText: 100,
            // ),
            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                text: offerModel.description,
                style: const TextStyle(
                  color: Color(0xFF9698A9),
                  fontSize: 12,
                  height: 1.75,
                ),
              ),
            ),
            const SizedBox(height: 64),
          ],
        ),
      );
}
