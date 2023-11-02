import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/savingmt_response.dart';

abstract class SavingMtState extends Equatable {
  const SavingMtState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends SavingMtState {}

class SavingMtLoaded extends SavingMtState {
  final List<SavingMtResponse> items;

  const SavingMtLoaded({this.items});

  SavingMtLoaded copyWith({
    List<SavingMtResponse> items,
  }) {
    return SavingMtLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {SavingMt: ${items.length} }';
}

//
//class SavingMtLoaded extends SavingMtState {
//  final List<SavingMtResponse> items;
//
//  const SavingMtLoaded({
//    this.items
//  });
//
//  SavingMtLoaded copyWith({
//    List<SavingMtResponse> items
//  }) {
//    return SavingMtLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'SavingMtLoaded { items: ${items.length}';
//}

class Failure extends SavingMtState {
  Failure(ex);

  @override
  String toString() => 'Failure {SavingMt:}';
}
