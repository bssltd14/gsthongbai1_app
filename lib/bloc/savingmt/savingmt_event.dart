import 'package:equatable/equatable.dart';

abstract class SavingMtEvent extends Equatable {
  const SavingMtEvent();

  @override
  List<Object> get props => [];
}

class FetchSavingMt extends SavingMtEvent {
  @override
  String toString() => "FetchSavingMt";
}
