part of 'subject_list_bloc.dart';

sealed class SubjectListEvent extends Equatable {
  const SubjectListEvent();

  @override
  List<Object> get props => [];
}

final class SubjectListFetched extends SubjectListEvent {
  const SubjectListFetched();
}
