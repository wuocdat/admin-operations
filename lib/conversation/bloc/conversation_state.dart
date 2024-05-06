part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.messages = const [],
    this.status = FetchDataStatus.initial,
    this.currentInputText = "",
    this.hasReachedMax = false,
  });

  final List<Message> messages;
  final FetchDataStatus status;
  final String currentInputText;
  final bool hasReachedMax;

  ConversationState copyWith({
    List<Message>? messages,
    FetchDataStatus? status,
    String? currentInputText,
    bool? hasReachedMax,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      currentInputText: currentInputText ?? this.currentInputText,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [messages, status, currentInputText, hasReachedMax];
}
