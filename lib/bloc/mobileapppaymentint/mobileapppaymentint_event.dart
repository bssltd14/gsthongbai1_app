import 'package:equatable/equatable.dart';

abstract class MobileAppPaymentIntEvent extends Equatable {
  const MobileAppPaymentIntEvent();

  @override
  List<Object> get props => [];
}

class FetchMobileAppPaymentInt extends MobileAppPaymentIntEvent {
  @override
  String toString() => "FetchMobileAppPaymentInt";
}
