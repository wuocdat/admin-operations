part of 'target_detail_bloc.dart';

sealed class TargetDetailEvent extends Equatable {
  const TargetDetailEvent();

  @override
  List<Object> get props => [];
}

final class PostsFetchedEvent extends TargetDetailEvent {
  const PostsFetchedEvent();

  @override
  List<Object> get props => [];
}

final class PostsReFetchedEvent extends TargetDetailEvent {
  const PostsReFetchedEvent();

  @override
  List<Object> get props => [];
}

final class TargetInfoFetchedEvent extends TargetDetailEvent {
  const TargetInfoFetchedEvent();

  @override
  List<Object> get props => [];
}
