part of 'conversation_bloc.dart';

sealed class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object> get props => [];
}

class DataFetchedEvent extends ConversationEvent {
  const DataFetchedEvent();

  @override
  List<Object> get props => [];
}

class MessageSentEvent extends ConversationEvent {
  const MessageSentEvent();

  @override
  List<Object> get props => [];
}

final class MessageTextInputChangedEvent extends ConversationEvent {
  const MessageTextInputChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class _NewMessageReceivedEvent extends ConversationEvent {
  const _NewMessageReceivedEvent(this.message);

  final Message message;

  @override
  List<Object> get props => [message];
}

final class ConversationInfoFetchedEvent extends ConversationEvent {
  const ConversationInfoFetchedEvent();

  @override
  List<Object> get props => [];
}

final class FilePicked extends ConversationEvent {
  const FilePicked(this.files);

  final List<PlatformFile> files;

  @override
  List<Object> get props => [files];
}

final class FilesCleared extends ConversationEvent {
  const FilesCleared();

  @override
  List<Object> get props => [];
}
