part of 'subject_action_bloc.dart';

class SubjectActionState extends Equatable {
  const SubjectActionState({
    this.posts = const [],
    this.status = FetchDataStatus.initial,
    this.hasReachedMax = false,
  });

  final List<Post> posts;
  final FetchDataStatus status;
  final bool hasReachedMax;

  SubjectActionState copyWith({
    List<Post>? posts,
    FetchDataStatus? status,
    bool? hasReachedMax,
  }) {
    return SubjectActionState(
      posts: posts ?? this.posts,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, status, hasReachedMax];
}
