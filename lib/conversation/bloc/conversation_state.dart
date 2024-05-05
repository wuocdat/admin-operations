part of 'conversation_bloc.dart';

class TextInput extends FormzInput<String, dynamic> {
  const TextInput.pure() : super.pure('');
  const TextInput.dirty([super.value = '']) : super.dirty();

  @override
  validator(String value) {}
}

class ConversationState extends Equatable {
  const ConversationState({
    this.messages = const [],
    this.status = FetchDataStatus.initial,
    this.messageTextInput = const TextInput.pure(),
  });

  final List<Message> messages;
  final FetchDataStatus status;
  final TextInput messageTextInput;

  ConversationState copyWith({
    List<Message>? messages,
    FetchDataStatus? status,
    TextInput? messageText,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      messageTextInput: messageText ?? this.messageTextInput,
    );
  }

  @override
  List<Object> get props => [messages, status, messageTextInput];
}
