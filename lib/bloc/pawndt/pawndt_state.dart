import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/pawndt_response.dart';

abstract class PawnDtState extends Equatable {
  const PawnDtState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends PawnDtState {}

class PawnDtLoaded extends PawnDtState {
  final List<PawnDtResponse> items;

  const PawnDtLoaded({this.items});

  PawnDtLoaded copyWith({
    List<PawnDtResponse> items,
  }) {
    return PawnDtLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {PawnDt: ${items.length} }';
}

//
//class PawnDtLoaded extends PawnDtState {
//  final List<PawnDtResponse> items;
//
//  const PawnDtLoaded({
//    this.items
//  });
//
//  PawnDtLoaded copyWith({
//    List<PawnDtResponse> items
//  }) {
//    return PawnDtLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'PawnDtLoaded { items: ${items.length}';
//}

class Failure extends PawnDtState {
  Failure(ex);

  @override
  String toString() => 'Failure {PawnDt:}';
}
