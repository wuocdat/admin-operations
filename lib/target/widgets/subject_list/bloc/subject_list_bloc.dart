import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'subject_list_event.dart';
part 'subject_list_state.dart';

class SubjectListBloc extends Bloc<SubjectListEvent, SubjectListState> {
  SubjectListBloc({required TargetRepository targetRepository})
      : _targetRepository = targetRepository,
        super(const SubjectListState()) {
    on<SubjectListFetched>(
      _onSubjectFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SubjectReFetchedEvent>(_onSubjectRefetched);
  }

  final TargetRepository _targetRepository;

  Future<void> _onSubjectRefetched(
    SubjectReFetchedEvent event,
    Emitter<SubjectListState> emit,
  ) async {
    emit(const SubjectListState(status: FetchDataStatus.loading));

    try {
      final subjects = await _targetRepository.fetchSubject(event.typeAc);

      subjects.length < subjectLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              subjects: subjects,
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              subjects: subjects,
            ));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onSubjectFetched(
    SubjectListFetched event,
    Emitter<SubjectListState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final subjects = await _targetRepository.fetchSubject(
          event.typeAc, state.subjects.length);

      subjects.length < subjectLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              subjects: List.of(state.subjects)..addAll(subjects),
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              subjects: List.of(state.subjects)..addAll(subjects),
            ));
    } catch (e) {
      print(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
