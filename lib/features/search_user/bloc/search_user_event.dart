part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class SearchInputChangeEvent extends SearchUserEvent {
  const SearchInputChangeEvent(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

class ModeChangedEvent extends SearchUserEvent {
  const ModeChangedEvent();

  @override
  List<Object> get props => [];
}

class CheckBoxStatusChangeEvent extends SearchUserEvent {
  const CheckBoxStatusChangeEvent(this.checked, this.user);

  final bool checked;
  final ShortProfile user;

  @override
  List<Object> get props => [checked, user];
}

class OneByOneConversationCreatedEvent extends SearchUserEvent {
  const OneByOneConversationCreatedEvent(this.otherUserId);

  final String otherUserId;

  @override
  List<Object> get props => [otherUserId];
}

class GroupConversationCreatedEvent extends SearchUserEvent {
  const GroupConversationCreatedEvent();

  @override
  List<Object> get props => [];
}

class _ConversationIdReceivedEvent extends SearchUserEvent {
  const _ConversationIdReceivedEvent(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class UserFetchedEvent extends SearchUserEvent {
  const UserFetchedEvent();

  @override
  List<Object> get props => [];
}

final class GroupNameChanged extends SearchUserEvent {
  const GroupNameChanged(this.groupName);

  final String groupName;

  @override
  List<Object> get props => [groupName];
}
