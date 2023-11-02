
import 'package:equatable/equatable.dart';

abstract class SavingEvent extends Equatable {
  const SavingEvent();

  @override
  List<Object> get props => [];
}

class FetchSaving extends SavingEvent {

  @override
  String toString()=> "FetchSaving";
}

