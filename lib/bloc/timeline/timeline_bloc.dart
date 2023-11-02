import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsthongbai1app/bloc/timeline/timeline_event.dart';
import 'package:gsthongbai1app/bloc/timeline/timeline_state.dart';
import 'package:gsthongbai1app/src/services/viewapimap_service.dart';

class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  var _timelineService = TimelineService();

  @override
  TimelineState get initialState => InitialTimelineState();

  @override
  Stream<TimelineState> mapEventToState(
    TimelineEvent event,
  ) async* {
    switch (event.runtimeType) {
      case Fetch:
        yield* _mapFetchToState(event);
        break;
      case Reload:
        yield* _mapReloadToState(event);
        break;
    }
  }

  bool _hasReachedMax(TimelineState state) =>
      state is TimelineLoaded && state.hasReachedMax;

  Stream<TimelineState> _mapFetchToState(TimelineEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialTimelineState) {
          final posts =
              await _timelineService.fetchPosts(0, 20, event.searchdetail);

          yield TimelineLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is TimelineLoaded) {
          final posts = await _timelineService.fetchPosts(
              currentState.posts.length, 20, event.searchdetail);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : TimelineLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (ex) {
        // make sure data type. it is dynamic
        yield TimelineError(ex.toString());
      }
    }
  }

  Stream<TimelineState> _mapReloadToState(Reload event) async* {
    try {
      yield InitialTimelineState();
      final posts = await _timelineService.fetchPosts(0, 20, "");
      yield TimelineLoaded(posts: posts, hasReachedMax: false);
    } catch (ex) {
      // make sure data type. it is dynamic
      yield TimelineError(ex.toString());
    }
  }
}
