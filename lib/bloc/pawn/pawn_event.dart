
import 'package:equatable/equatable.dart';

abstract class PawnEvent extends Equatable {
  const PawnEvent();

  @override
  List<Object> get props => [];
}

class FetchPawn extends PawnEvent {

  @override
  String toString()=> "FetchPawn";
}

