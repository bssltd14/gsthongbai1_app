import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/bloc/pawnitem/pawnitem_event.dart';
import 'package:gsthongbai1app/bloc/pawnitem/pawnitem_state.dart';
import 'package:gsthongbai1app/src/services/pawnitem_service.dart';

class PawnItemBloc extends Bloc<PawnItemEvent, PawnItemState> {
//  final PawnItemService pawnItemItemService;
  var _pawnItemItemservice = PawnItemService();

//
//  PawnItemBloc({this.pawnItemItemService});

  @override
  PawnItemState get initialState => Loading();

  @override
  Stream<PawnItemState> mapEventToState(
    PawnItemEvent event,
  ) async* {
    if (event is FetchPawnItem) {
      try {
        final items = await _pawnItemItemservice.fetchPawnItem(
            event.searchPawnId, event.searchBranchName);
        yield PawnItemLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
