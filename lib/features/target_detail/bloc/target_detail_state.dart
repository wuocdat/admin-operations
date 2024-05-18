part of 'target_detail_bloc.dart';

class TargetDetailState extends Equatable {
  const TargetDetailState({
    this.target = Subject.empty,
    this.posts = const [],
    this.status = FetchDataStatus.initial,
    this.hasReachedMax = false,
  });

  final Subject target;
  final List<Post> posts;
  final FetchDataStatus status;
  final bool hasReachedMax;

  TargetDetailState copyWith({
    Subject? target,
    List<Post>? posts,
    FetchDataStatus? status,
    bool? hasReachedMax,
  }) {
    return TargetDetailState(
      target: target ?? this.target,
      posts: posts ?? this.posts,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [target, posts, status, hasReachedMax];
}
