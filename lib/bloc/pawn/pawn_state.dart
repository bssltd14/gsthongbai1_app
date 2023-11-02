import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/pawn_response.dart';

abstract class PawnState extends Equatable {
  const PawnState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends PawnState {}

class PawnLoaded extends PawnState {
  final List<PawnResponse> items;

  const PawnLoaded({this.items});

  PawnLoaded copyWith({
    List<PawnResponse> items,
  }) {
    return PawnLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {Pawn: ${items.length} }';
}

//
//class PawnLoaded extends PawnState {
//  final List<PawnResponse> items;
//
//  const PawnLoaded({
//    this.items
//  });
//
//  PawnLoaded copyWith({
//    List<PawnResponse> items
//  }) {
//    return PawnLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'PawnLoaded { items: ${items.length}';
//}

class Failure extends PawnState {
  Failure(ex);

  @override
  String toString() => 'Failure {Pawn:}';
}
