part of 'member_manager_bloc.dart';

sealed class MemberManagerEvent extends Equatable {
  const MemberManagerEvent();

  @override
  List<Object> get props => [];
}

class MemberFetchedEvent extends MemberManagerEvent {
  const MemberFetchedEvent(this.unitId);

  final String unitId;

  @override
  List<Object> get props => [];
}
