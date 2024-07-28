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
