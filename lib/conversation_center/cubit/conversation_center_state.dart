part of 'conversation_center_cubit.dart';

class ConversationCenterState extends Equatable {
  const ConversationCenterState({
    this.conversations = const [],
    this.status = FetchDataStatus.initial,
  });

  final List<Conversation> conversations;
  final FetchDataStatus status;

  ConversationCenterState copyWith({
    List<Conversation>? conversations,
    FetchDataStatus? status,
  }) {
    return ConversationCenterState(
      conversations: conversations ?? this.conversations,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [conversations, status];
}
