import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/offer_model.dart';

class  OfferService {
  final CollectionReference  offersCollection =
      FirebaseFirestore.instance.collection('offers');

  Future<DocumentReference<Object?>> addOffer(OfferModel offer) async {
    return await  offersCollection.add(offer.toJson());
  }

  Stream<QuerySnapshot> getOffers() {
    return  offersCollection.snapshots();
  }

  Future<void> updateOffer(OfferModel offer) async {
    return await  offersCollection.doc(offer.id).update(offer.toJson());
  }

  Future<void> deleteOffer(String  offerId) async {
    return await  offersCollection.doc( offerId).delete();
  }
}
