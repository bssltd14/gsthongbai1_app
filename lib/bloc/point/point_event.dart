
import 'package:equatable/equatable.dart';

abstract class PointEvent extends Equatable {
  const PointEvent();

  @override
  List<Object> get props => [];
}

class FetchPoint extends PointEvent {

  @override
  String toString()=> "FetchPoint";
}

