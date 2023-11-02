import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/src/services/mobileapppayment_service.dart';

import 'mobileapppayment_event.dart';
import 'mobileapppayment_state.dart';

class MobileAppPaymentBloc
    extends Bloc<MobileAppPaymentEvent, MobileAppPaymentState> {
  var _mobileAppPaymentservice = MobileAppPaymentService();

  @override
  MobileAppPaymentState get initialState => Loading();

  @override
  Stream<MobileAppPaymentState> mapEventToState(
    MobileAppPaymentEvent event,
  ) async* {
    if (event is FetchMobileAppPayment) {
      try {
        final items = await _mobileAppPaymentservice.fetchMobileAppPayment();
        yield MobileAppPaymentLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
