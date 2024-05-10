part of 'subject_list_bloc.dart';

class SubjectListState extends Equatable {
  const SubjectListState({
    this.subjects = const <Subject>[],
    this.status = FetchDataStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Subject> subjects;
  final FetchDataStatus status;
  final bool hasReachedMax;

  SubjectListState copyWith({
    List<Subject>? subjects,
    FetchDataStatus? status,
    bool? hasReachedMax,
  }) {
    return SubjectListState(
      subjects: subjects ?? this.subjects,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [subjects, status, hasReachedMax];
}
