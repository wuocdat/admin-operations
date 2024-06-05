part of 'member_manager_bloc.dart';

sealed class MemberManagerEvent extends Equatable {
  const MemberManagerEvent();

  @override
  List<Object> get props => [];
}

class MemberFetchedEvent extends MemberManagerEvent {
  const MemberFetchedEvent(this.unitId, this.pageSize, this.currentpage);

  final String unitId;

  final int pageSize;

  final int currentpage;

  @override
  List<Object> get props => [];
}
