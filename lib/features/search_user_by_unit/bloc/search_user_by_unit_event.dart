part of 'search_user_by_unit_bloc.dart';

sealed class SearchUserByUnitEvent extends Equatable {
  const SearchUserByUnitEvent();
}

final class RootUserFetchedEvent extends SearchUserByUnitEvent {
  const RootUserFetchedEvent();

  @override
  List<Object> get props => [];
}

final class ChatUsersFetchedEvent extends SearchUserByUnitEvent {
  const ChatUsersFetchedEvent({required this.currentUnit});

  final Unit currentUnit;

  @override
  List<Object> get props => [currentUnit];
}

final class UnitSelectedEvent extends SearchUserByUnitEvent {
  const UnitSelectedEvent({required this.selectedUnit});

  final UnitNode selectedUnit;

  @override
  List<Object> get props => [selectedUnit];
}

class OneByOneConversationCreatedEvent extends SearchUserByUnitEvent {
  const OneByOneConversationCreatedEvent(this.otherUserId);

  final String otherUserId;

  @override
  List<Object> get props => [otherUserId];
}

class _ConversationIdReceivedEvent extends SearchUserByUnitEvent {
  const _ConversationIdReceivedEvent(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}