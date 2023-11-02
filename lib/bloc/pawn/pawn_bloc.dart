import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gsthongbai1app/bloc/pawn/pawn_event.dart';
import 'package:gsthongbai1app/bloc/pawn/pawn_state.dart';
import 'package:gsthongbai1app/src/models/pawn_response.dart';
import 'package:gsthongbai1app/src/services/pawn_service.dart';

class PawnBloc extends Bloc<PawnEvent, PawnState> {
//  final PawnService pawnService;
  var _pawnservice = PawnService();

//
//  PawnBloc({this.pawnService});

  @override
  PawnState get initialState => Loading();

  @override
  Stream<PawnState> mapEventToState(
    PawnEvent event,
  ) async* {
    if (event is FetchPawn) {
      try {
        final items = await _pawnservice.fetchPawn();
        yield PawnLoaded(items: items);
      } catch (ex) {
        yield Failure(ex);
      }
    }
  }
}
