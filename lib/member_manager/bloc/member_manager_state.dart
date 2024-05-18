part of 'member_manager_bloc.dart';

sealed class MemberManagerState extends Equatable {
  const MemberManagerState();
  
  @override
  List<Object> get props => [];
}

final class MemberManagerInitial extends MemberManagerState {}
