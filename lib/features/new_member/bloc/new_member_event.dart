part of 'new_member_bloc.dart';

sealed class NewMemberEvent extends Equatable {
  const NewMemberEvent();

  @override
  List<Object> get props => [];
}

final class MemberNameChangedEvent extends NewMemberEvent {
  const MemberNameChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class MemberUserNameChangedEvent extends NewMemberEvent {
  const MemberUserNameChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class MemberPasswordChangedEvent extends NewMemberEvent {
  const MemberPasswordChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class MemberRepeatPassChangedEvent extends NewMemberEvent {
  const MemberRepeatPassChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class MemberRoleChangedEvent extends NewMemberEvent {
  const MemberRoleChangedEvent(this.role);

  final ERole role;

  @override
  List<Object> get props => [role];
}

final class NewMemberSubmittedEvent extends NewMemberEvent {
  const NewMemberSubmittedEvent();

  @override
  List<Object> get props => [];
}
