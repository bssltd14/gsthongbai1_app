import 'package:equatable/equatable.dart';

abstract class MobileAppPaymentEvent extends Equatable {
  const MobileAppPaymentEvent();

  @override
  List<Object> get props => [];
}

class FetchMobileAppPayment extends MobileAppPaymentEvent {
  @override
  String toString() => "FetchMobileAppPayment";
}
