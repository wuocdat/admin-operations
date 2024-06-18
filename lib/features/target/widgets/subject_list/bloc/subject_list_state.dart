part of 'subject_list_bloc.dart';

class SubjectListState extends Equatable {
  const SubjectListState({
    this.subjects = const <Subject>[],
    this.status = FetchDataStatus.initial,
    this.deleteStatus = FetchDataStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Subject> subjects;
  final FetchDataStatus status;
  final FetchDataStatus deleteStatus;
  final bool hasReachedMax;

  SubjectListState copyWith({
    List<Subject>? subjects,
    FetchDataStatus? status,
    FetchDataStatus? deleteStatus,
    bool? hasReachedMax,
  }) {
    return SubjectListState(
      subjects: subjects ?? this.subjects,
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [subjects, status, hasReachedMax, deleteStatus];
}
