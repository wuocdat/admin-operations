part of 'subject_list_bloc.dart';

sealed class SubjectListEvent extends Equatable {
  const SubjectListEvent();

  @override
  List<Object?> get props => [];
}

final class SubjectListFetched extends SubjectListEvent {
  const SubjectListFetched({required this.typeAc, this.fbPageType});

  final int typeAc;
  final FbPageType? fbPageType;

  @override
  List<Object?> get props => [typeAc, fbPageType];
}

final class SubjectReFetchedEvent extends SubjectListEvent {
  const SubjectReFetchedEvent({required this.typeAc, this.fbPageType});

  final int typeAc;
  final FbPageType? fbPageType;

  @override
  List<Object?> get props => [typeAc, fbPageType];
}

final class SubjectDeletedEvent extends SubjectListEvent {
  const SubjectDeletedEvent({required this.subjectId});

  final String subjectId;

  @override
  List<Object> get props => [subjectId];
}
