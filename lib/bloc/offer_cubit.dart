import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covoiturage/model/offer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'offer_state.dart';

class OfferCubit extends Cubit<OfferState> {
  OfferCubit() : super(OfferInitial());
  final CollectionReference offersCollection =
      FirebaseFirestore.instance.collection('offers');

  void listenToOffers() {
    emit(OfferLoading());

    offersCollection.snapshots().listen((QuerySnapshot snapshot) {
      List<OfferModel> offers = snapshot.docs.map((DocumentSnapshot doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return OfferModel.fromJson(data);
      }).toList();
      emit(OfferLoaded(offers: offers));
    }, onError: (dynamic error) {
      emit(OfferError(message: 'There is no data!'));
    });
  }
}
