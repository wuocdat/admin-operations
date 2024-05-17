part of 'subject_action_bloc.dart';

sealed class SubjectActionEvent extends Equatable {
  const SubjectActionEvent({required this.typeAc});

  final int typeAc;

  @override
  List<Object> get props => [typeAc];
}

final class PostsFetchedEvent extends SubjectActionEvent {
  const PostsFetchedEvent({required super.typeAc});

  @override
  List<Object> get props => [];
}

final class PostsReFetchedEvent extends SubjectActionEvent {
  const PostsReFetchedEvent({required super.typeAc});

  @override
  List<Object> get props => [];
}
