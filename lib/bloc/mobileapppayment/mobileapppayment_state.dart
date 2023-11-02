import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/mobileapppayment_response.dart';

abstract class MobileAppPaymentState extends Equatable {
  const MobileAppPaymentState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends MobileAppPaymentState {}

class MobileAppPaymentLoaded extends MobileAppPaymentState {
  final List<MobileAppPaymentResponse> items;

  const MobileAppPaymentLoaded({this.items});

  MobileAppPaymentLoaded copyWith({
    List<MobileAppPaymentResponse> items,
  }) {
    return MobileAppPaymentLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {MobileAppPayment: ${items.length} }';
}

//
//class MobileAppPaymentLoaded extends MobileAppPaymentState {
//  final List<MobileAppPaymentResponse> items;
//
//  const MobileAppPaymentLoaded({
//    this.items
//  });
//
//  MobileAppPaymentLoaded copyWith({
//    List<MobileAppPaymentResponse> items
//  }) {
//    return MobileAppPaymentLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'MobileAppPaymentLoaded { items: ${items.length}';
//}

class Failure extends MobileAppPaymentState {
  Failure(ex);

  @override
  String toString() => 'Failure {MobileAppPayment:}';
}
