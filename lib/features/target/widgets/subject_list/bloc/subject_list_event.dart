part of 'subject_list_bloc.dart';

sealed class SubjectListEvent extends Equatable {
  const SubjectListEvent();

  @override
  List<Object?> get props => [];
}

final class SubjectListFetched extends SubjectListEvent {
  const SubjectListFetched({
    required this.typeAc,
    this.fbPageType,
    required this.name,
    required this.unitId,
  });

  final int typeAc;
  final FbPageType? fbPageType;
  final String name;
  final String unitId;

  @override
  List<Object?> get props => [typeAc, fbPageType, name, unitId];
}

final class SubjectReFetchedEvent extends SubjectListEvent {
  const SubjectReFetchedEvent({
    required this.typeAc,
    this.fbPageType,
    required this.name,
    required this.unitId,
  });

  final int typeAc;
  final FbPageType? fbPageType;
  final String name;
  final String unitId;

  @override
  List<Object?> get props => [typeAc, fbPageType, name, unitId];
}

final class SubjectDeletedEvent extends SubjectListEvent {
  const SubjectDeletedEvent({required this.subjectId});

  final String subjectId;

  @override
  List<Object> get props => [subjectId];
}
