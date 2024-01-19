import 'package:flutter_bloc/flutter_bloc.dart';

enum OfferEvent { edit, delete }

class OfferBloc extends Bloc<OfferEvent, String> {
  OfferBloc() : super("");

  @override
  Stream<String> mapEventToState(OfferEvent event) async* {
    switch (event) {
      case OfferEvent.edit:
        yield "edit";
        break;
      case OfferEvent.delete:
        yield "delete";
        break;
    }
  }
}
