part of 'conversation_bloc.dart';

class ConversationState extends Equatable {
  const ConversationState({
    this.messages = const [],
    this.status = FetchDataStatus.initial,
    this.headerStatus = FetchDataStatus.initial,
    this.currentInputText = "",
    this.hasReachedMax = false,
    this.conversationInfo = Conversation.empty,
    this.files = const [],
    this.showUploadingMessage = false,
  });

  final List<Message> messages;
  final FetchDataStatus status;
  final FetchDataStatus headerStatus;
  final String currentInputText;
  final bool hasReachedMax;
  final Conversation conversationInfo;
  final List<PlatformFile> files;
  final bool showUploadingMessage;

  ConversationState copyWith({
    List<Message>? messages,
    FetchDataStatus? status,
    FetchDataStatus? headerStatus,
    String? currentInputText,
    bool? hasReachedMax,
    Conversation? conversationInfo,
    List<PlatformFile>? files,
    bool? showUploadingMessage,
  }) {
    return ConversationState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      headerStatus: headerStatus ?? this.headerStatus,
      currentInputText: currentInputText ?? this.currentInputText,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      conversationInfo: conversationInfo ?? this.conversationInfo,
      files: files ?? this.files,
      showUploadingMessage: showUploadingMessage ?? this.showUploadingMessage,
    );
  }

  @override
  List<Object> get props => [
        messages,
        status,
        currentInputText,
        hasReachedMax,
        headerStatus,
        files,
        showUploadingMessage
      ];
}
