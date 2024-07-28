part of 'member_manager_bloc.dart';

class MemberManagerState extends Equatable {
  const MemberManagerState({
    this.users = const [],
    this.status = FetchDataStatus.initial,
    this.deleteStatus = FetchDataStatus.initial,
    this.hasReachedMax = false,
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final FetchDataStatus deleteStatus;
  final bool hasReachedMax;

  MemberManagerState copyWith({
    List<ShortProfile>? users,
    FetchDataStatus? status,
    FetchDataStatus? deleteStatus,
    bool? hasReachedMax,
  }) {
    return MemberManagerState(
      users: users ?? this.users,
      status: status ?? this.status,
      deleteStatus: deleteStatus ?? this.deleteStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [users, status, hasReachedMax, deleteStatus];
}
