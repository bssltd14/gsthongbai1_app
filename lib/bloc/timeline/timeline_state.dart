import 'package:equatable/equatable.dart';
import 'package:gsthongbai1app/src/models/viewapimap_response.dart';

abstract class TimelineState extends Equatable {
  const TimelineState();

  @override
  List<Object> get props => [];
}

class InitialTimelineState extends TimelineState {}

class TimelineLoaded extends TimelineState {
  final List<ViewAPIMAPResponse> posts;
  final bool hasReachedMax;

  const TimelineLoaded({
    this.posts,
    this.hasReachedMax,
  });

  TimelineLoaded copyWith({
    List<ViewAPIMAPResponse> posts,
    bool hasReachedMax,
  }) {
    return TimelineLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}

class TimelineError extends TimelineState {
  final String error;

  const TimelineError(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() => "Error: $error";
}
