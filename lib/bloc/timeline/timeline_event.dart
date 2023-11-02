import 'package:equatable/equatable.dart';

abstract class TimelineEvent extends Equatable {
  const TimelineEvent();

  @override
  List<Object> get props => [];
}

class Fetch extends TimelineEvent {
  final String searchdetail;

  Fetch(this.searchdetail);

  @override
  String toString() => "Fetch{searchdetail:$searchdetail}";
}

class Reload extends TimelineEvent {
  String searchdetail;

  Reload(this.searchdetail);

  @override
  String toString() => "Reload{searchdetail:$searchdetail}";
}
