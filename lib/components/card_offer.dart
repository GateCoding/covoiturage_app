import 'package:covoiturage/components/colors.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:covoiturage/model/user_model.dart';
import 'package:covoiturage/service/user_service.dart';
import 'package:covoiturage/utils/app_decoration.dart';
import 'package:flutter/material.dart';

class CardOffer extends StatefulWidget {
  final OfferModel offerModel;

  const CardOffer({required this.offerModel, Key? key}) : super(key: key);

  @override
  _CardOfferState createState() => _CardOfferState();
}

class _CardOfferState extends State<CardOffer> {
  UserModel? _creator;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void getDataUser() async {
    UserService userService = UserService();
    UserModel? userModel =
        await userService.getUserByUid(widget.offerModel.idCreateur!);

    setState(() {
      _creator = userModel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, top: 6),
      child: Container(
        height: 200,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: const Color(0XFF000000).withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(right: 1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        "${widget.offerModel.dateStart}",
                        style: const TextStyle(
                          color: Color(0XFF131313),
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Image.asset(
                              'assets/images/ic_location.png',
                              width: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(
                              "${widget.offerModel.from}",
                              style: const TextStyle(
                                color: Color(0XFF131313),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              // width: 61,
                              margin: const EdgeInsets.only(right: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 1,
                              ),
                              decoration: AppDecoration.fillTeal.copyWith(
                                borderRadius: BorderRadiusStyle.circleBorder10,
                              ),
                              child: Text(
                                "${widget.offerModel.montant}DH",
                                style: const TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 6, top: 8),
                      child: Padding(
                        padding: EdgeInsets.only(left: 18),
                        child: SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            width: 80,
                            thickness: 2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        SizedBox(
                          height: 27,
                          width: 130,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Image.asset(
                                  'assets/images/ic_location.png',
                                  width: 16,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 75),
                                child: Text(
                                  "${widget.offerModel.to}",
                                  style: const TextStyle(
                                    color: Color(0XFF131313),
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 25,
                            width: 106,
                            margin: const EdgeInsets.only(left: 68),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 24,
                                    width: 106,
                                    decoration: BoxDecoration(
                                      color: const Color(0XFF008955),
                                      borderRadius: BorderRadius.circular(
                                        8,
                                      ),
                                    ),
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Book now",
                                    style: TextStyle(
                                      color: Color(0XFFFFFFFF),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Padding(
                      padding: const EdgeInsets.only(right: 1),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("${_creator?.imagePath}"),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 12,
                              bottom: 12,
                            ),
                            child: Text(
                              "${_creator?.username}",
                              style: const TextStyle(
                                color: Color(0XFF008955),
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                              top: 6,
                            ),
                            child: Text(
                              "4,5",
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
