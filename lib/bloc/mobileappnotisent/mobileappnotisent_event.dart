import 'package:equatable/equatable.dart';

abstract class MobileAppNotiSentEvent extends Equatable {
  const MobileAppNotiSentEvent();

  @override
  List<Object> get props => [];
}

class FetchMobileAppNotiSent extends MobileAppNotiSentEvent {
  @override
  String toString() => "FetchMobileAppNotiSent";
}
