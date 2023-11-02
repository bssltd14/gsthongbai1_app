import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/bloc/pawndt/pawndt_event.dart';
import 'package:gsthongbai1app/bloc/pawndt/pawndt_state.dart';
import 'package:gsthongbai1app/src/services/pawnDt_service.dart';

class PawnDtBloc extends Bloc<PawnDtEvent, PawnDtState> {
//  final PawnDtService pawnDtService;
  var _pawnDtservice = PawnDtService();

//
//  PawnDtBloc({this.pawnDtService});

  @override
  PawnDtState get initialState => Loading();

  @override
  Stream<PawnDtState> mapEventToState(
    PawnDtEvent event,
  ) async* {
    if (event is FetchPawnDt) {
      try {
        final items = await _pawnDtservice.fetchPawnDt(
            event.searchPawnId, event.searchBranchName);
        yield PawnDtLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
