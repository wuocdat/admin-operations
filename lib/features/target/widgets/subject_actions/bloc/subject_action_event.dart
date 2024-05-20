part of 'subject_action_bloc.dart';

sealed class SubjectActionEvent extends Equatable {
  const SubjectActionEvent({
    required this.typeAc,
    required this.startDate,
    required this.endDate,
  });

  final int typeAc;
  final String startDate;
  final String endDate;

  @override
  List<Object> get props => [typeAc, startDate, endDate];
}

final class PostsFetchedEvent extends SubjectActionEvent {
  const PostsFetchedEvent({
    required super.typeAc,
    required super.startDate,
    required super.endDate,
  });

  @override
  List<Object> get props => [];
}

final class PostsReFetchedEvent extends SubjectActionEvent {
  const PostsReFetchedEvent({
    required super.typeAc,
    required super.startDate,
    required super.endDate,
  });

  @override
  List<Object> get props => [];
}
