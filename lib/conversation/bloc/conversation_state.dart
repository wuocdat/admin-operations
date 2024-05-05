part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.messages = const [],
    this.status = FetchDataStatus.initial,
    this.currentInputText = "",
  });

  final List<Message> messages;
  final FetchDataStatus status;
  final String currentInputText;

  ConversationState copyWith({
    List<Message>? messages,
    FetchDataStatus? status,
    String? currentInputText,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      currentInputText: currentInputText ?? this.currentInputText,
    );
  }

  @override
  List<Object> get props => [messages, status, currentInputText];
}
