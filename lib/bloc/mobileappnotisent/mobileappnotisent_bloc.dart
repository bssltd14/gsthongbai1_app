import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/bloc/mobileappnotisent/mobileappnotisent_event.dart';
import 'package:gsthongbai1app/bloc/mobileappnotisent/mobileappnotisent_state.dart';
import 'package:gsthongbai1app/src/services/mobileappnotisent_service.dart';

class MobileAppNotiSentBloc
    extends Bloc<MobileAppNotiSentEvent, MobileAppNotiSentState> {
  var _mobileAppNotiSentservice = MobileAppNotiSentService();

  @override
  MobileAppNotiSentState get initialState => Loading();

  @override
  Stream<MobileAppNotiSentState> mapEventToState(
    MobileAppNotiSentEvent event,
  ) async* {
    if (event is FetchMobileAppNotiSent) {
      try {
        final items = await _mobileAppNotiSentservice.fetchMobileAppNotiSent();
        yield MobileAppNotiSentLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
