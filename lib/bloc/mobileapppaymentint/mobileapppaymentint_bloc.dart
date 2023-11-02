import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/bloc/mobileapppaymentint/mobileapppaymentint_event.dart';
import 'package:gsthongbai1app/src/services/mobileapppaymentint_service.dart';

import 'mobileapppaymentint_state.dart';

class MobileAppPaymentIntBloc
    extends Bloc<MobileAppPaymentIntEvent, MobileAppPaymentIntState> {
  var _mobileAppPaymentIntservice = MobileAppPaymentIntService();

  @override
  MobileAppPaymentIntState get initialState => Loading();

  @override
  Stream<MobileAppPaymentIntState> mapEventToState(
    MobileAppPaymentIntEvent event,
  ) async* {
    if (event is FetchMobileAppPaymentInt) {
      try {
        final items =
            await _mobileAppPaymentIntservice.fetchMobileAppPaymentInt();
        yield MobileAppPaymentIntLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
