part of 'subject_list_bloc.dart';

sealed class SubjectListEvent extends Equatable {
  const SubjectListEvent();

  @override
  List<Object> get props => [];
}

final class SubjectListFetched extends SubjectListEvent {
  const SubjectListFetched({required this.typeAc});

  final int typeAc;

  @override
  List<Object> get props => [typeAc];
}

final class SubjectReFetchedEvent extends SubjectListEvent {
  const SubjectReFetchedEvent({required this.typeAc});

  final int typeAc;

  @override
  List<Object> get props => [typeAc];
}
