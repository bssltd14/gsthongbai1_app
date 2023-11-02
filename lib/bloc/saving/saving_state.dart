import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/saving_response.dart';

abstract class SavingState extends Equatable {
  const SavingState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends SavingState {}

class SavingLoaded extends SavingState {
  final List<SavingResponse> items;

  const SavingLoaded({this.items});

  SavingLoaded copyWith({
    List<SavingResponse> items,
  }) {
    return SavingLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {Saving: ${items.length} }';
}

//
//class SavingLoaded extends SavingState {
//  final List<SavingResponse> items;
//
//  const SavingLoaded({
//    this.items
//  });
//
//  SavingLoaded copyWith({
//    List<SavingResponse> items
//  }) {
//    return SavingLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'SavingLoaded { items: ${items.length}';
//}

class Failure extends SavingState {
  Failure(ex);

  @override
  String toString() => 'Failure {Saving:}';
}
