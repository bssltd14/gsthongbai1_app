import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/mobileappnotisent_response.dart';

abstract class MobileAppNotiSentState extends Equatable {
  const MobileAppNotiSentState();

  @override
  List<Object> get props => [];

  get items => null;
}

class Loading extends MobileAppNotiSentState {}

class MobileAppNotiSentLoaded extends MobileAppNotiSentState {
  final List<MobileAppNotiSentResponse> items;

  const MobileAppNotiSentLoaded({this.items});

  MobileAppNotiSentLoaded copyWith({
    List<MobileAppNotiSentResponse> items,
  }) {
    return MobileAppNotiSentLoaded(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];

  @override
  String toString() => 'Loaded {MobileAppNotiSent: ${items.length} }';
}

//
//class MobileAppNotiSentLoaded extends MobileAppNotiSentState {
//  final List<MobileAppNotiSentResponse> items;
//
//  const MobileAppNotiSentLoaded({
//    this.items
//  });
//
//  MobileAppNotiSentLoaded copyWith({
//    List<MobileAppNotiSentResponse> items
//  }) {
//    return MobileAppNotiSentLoaded(
//        items: items ?? this.items
//    );
//  }
//
//  @override
//  List<Object> get props => [items];
//
//  @override
//  String toString() =>
//      'MobileAppNotiSentLoaded { items: ${items.length}';
//}

class Failure extends MobileAppNotiSentState {
  Failure(ex);

  @override
  String toString() => 'Failure {MobileAppNotiSent:}';
}
