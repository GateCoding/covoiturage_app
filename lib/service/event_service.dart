import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/offer_model.dart';

class EventService {
  final CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');

  Future<DocumentReference<Object?>> addEvent(OfferModel offer) async {
    return await eventsCollection.add(offer.toJson());
  }

  Stream<QuerySnapshot> getEvents() {
    return eventsCollection.snapshots();
  }

  Future<void> updateEvent(OfferModel offer) async {
    return await eventsCollection.doc(offer.id).update(offer.toJson());
  }

  Future<void> deleteEvent(String eventId) async {
    return await eventsCollection.doc(eventId).delete();
  }
}
