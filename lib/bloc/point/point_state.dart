import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/point_response.dart';

abstract class PointState extends Equatable {
  const PointState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends PointState {}

class PointLoaded extends PointState {
  final List<PointResponse> items;

  const PointLoaded({this.items});

  PointLoaded copyWith({
    List<PointResponse> items,
  }) {
    return PointLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {Point: ${items.length} }';
}

//
//class PointLoaded extends PointState {
//  final List<PointResponse> items;
//
//  const PointLoaded({
//    this.items
//  });
//
//  PointLoaded copyWith({
//    List<PointResponse> items
//  }) {
//    return PointLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'PointLoaded { items: ${items.length}';
//}

class Failure extends PointState {
  Failure(ex);

  @override
  String toString() => 'Failure {Point:}';
}
