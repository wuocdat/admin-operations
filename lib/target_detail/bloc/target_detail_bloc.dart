import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'target_detail_event.dart';
part 'target_detail_state.dart';

class TargetDetailBloc extends Bloc<TargetDetailEvent, TargetDetailState> {
  TargetDetailBloc(
      {required TargetRepository targetRepository, required String targetId})
      : _targetRepository = targetRepository,
        _targetId = targetId,
        super(const TargetDetailState()) {
    on<PostsFetchedEvent>(
      _onPostsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PostsReFetchedEvent>(_onPostsRefetched);
  }

  final TargetRepository _targetRepository;
  final String _targetId;

  Future<void> _onPostsRefetched(
    PostsReFetchedEvent event,
    Emitter<TargetDetailState> emit,
  ) async {
    emit(const TargetDetailState(status: FetchDataStatus.loading));

    try {
      final posts = await _targetRepository.fetchPosts(_targetId);

      posts.length < subjectLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              posts: posts,
            ))
          : emit(state.copyWith(
              hasReachedMax: false,
              status: FetchDataStatus.success,
              posts: posts,
            ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onPostsFetched(
    PostsFetchedEvent event,
    Emitter<TargetDetailState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final posts =
          await _targetRepository.fetchPosts(_targetId, state.posts.length);

      posts.length < subjectLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              posts: List.of(state.posts)..addAll(posts),
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              posts: List.of(state.posts)..addAll(posts),
            ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
