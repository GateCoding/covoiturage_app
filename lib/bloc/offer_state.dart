part of 'offer_cubit.dart';

abstract class OfferState {}

class OfferInitial extends OfferState {}

class OfferLoaded extends OfferState {
  final List<OfferModel> offers;

  OfferLoaded({required this.offers});
}

class OfferLoading extends OfferState {}

class OfferError extends OfferState {
  final String message;

  OfferError({required this.message});
}
