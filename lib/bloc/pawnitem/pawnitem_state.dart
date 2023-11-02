import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/pawnItem_response.dart';

abstract class PawnItemState extends Equatable {
  const PawnItemState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends PawnItemState {}

class PawnItemLoaded extends PawnItemState {
  final List<PawnItemResponse> items;

  const PawnItemLoaded({this.items});

  PawnItemLoaded copyWith({
    List<PawnItemResponse> items,
  }) {
    return PawnItemLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {PawnItem: ${items.length} }';
}

//
//class PawnItemLoaded extends PawnItemState {
//  final List<PawnItemResponse> items;
//
//  const PawnItemLoaded({
//    this.items
//  });
//
//  PawnItemLoaded copyWith({
//    List<PawnItemResponse> items
//  }) {
//    return PawnItemLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'PawnItemLoaded { items: ${items.length}';
//}

class Failure extends PawnItemState {
  Failure(ex);

  @override
  String toString() => 'Failure {PawnItem:}';
}
