part of 'member_manager_bloc.dart';

sealed class MemberManagerEvent extends Equatable {
  const MemberManagerEvent();

  @override
  List<Object> get props => [];
}

final class UserFetchedEvent extends MemberManagerEvent {
  const UserFetchedEvent();

  @override
  List<Object> get props => [];
}

final class UserReFetchedEvent extends MemberManagerEvent {
  const UserReFetchedEvent();

  @override
  List<Object> get props => [];
}

final class UserDeletedEvent extends MemberManagerEvent {
  const UserDeletedEvent(this.userId);

  final String userId;

  @override
  List<Object> get props => [userId];
}
