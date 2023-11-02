import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/mobileapppaymentint_response.dart';

abstract class MobileAppPaymentIntState extends Equatable {
  const MobileAppPaymentIntState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends MobileAppPaymentIntState {}

class MobileAppPaymentIntLoaded extends MobileAppPaymentIntState {
  final List<MobileAppPaymentIntResponse> items;

  const MobileAppPaymentIntLoaded({this.items});

  MobileAppPaymentIntLoaded copyWith({
    List<MobileAppPaymentIntResponse> items,
  }) {
    return MobileAppPaymentIntLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {MobileAppPaymentInt: ${items.length} }';
}

//
//class MobileAppPaymentIntLoaded extends MobileAppPaymentIntState {
//  final List<MobileAppPaymentIntResponse> items;
//
//  const MobileAppPaymentIntLoaded({
//    this.items
//  });
//
//  MobileAppPaymentIntLoaded copyWith({
//    List<MobileAppPaymentIntResponse> items
//  }) {
//    return MobileAppPaymentIntLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'MobileAppPaymentIntLoaded { items: ${items.length}';
//}

class Failure extends MobileAppPaymentIntState {
  Failure(ex);

  @override
  String toString() => 'Failure {MobileAppPaymentInt:}';
}
