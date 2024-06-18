import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'subject_action_event.dart';
part 'subject_action_state.dart';

class SubjectActionBloc extends Bloc<SubjectActionEvent, SubjectActionState> {
  SubjectActionBloc(
      {required TargetRepository targetRepository, required String unitId})
      : _targetRepository = targetRepository,
        super(const SubjectActionState()) {
    on<PostsFetchedEvent>(
      _onPostsFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<PostsReFetchedEvent>(_onPostsRefetched);
  }

  final TargetRepository _targetRepository;

  Future<void> _onPostsRefetched(
    PostsReFetchedEvent event,
    Emitter<SubjectActionState> emit,
  ) async {
    emit(const SubjectActionState(status: FetchDataStatus.loading));

    try {
      final posts = await _targetRepository.fetchPostsByUnit(
          event.typeAc, event.unitId, event.startDate, event.endDate);

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
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onPostsFetched(
    PostsFetchedEvent event,
    Emitter<SubjectActionState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final posts = await _targetRepository.fetchPostsByUnit(event.typeAc,
          event.unitId, event.startDate, event.endDate, state.posts.length);

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
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
