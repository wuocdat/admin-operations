import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tctt_mobile/core/services/socket_service.dart';
import 'package:tctt_mobile/core/utils/constants.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'conversation_event.dart';

part 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc(
      {required ConversationRepository conversationRepository,
      required String conversationId})
      : _conversationRepository = conversationRepository,
        _conversationId = conversationId,
        _socketIOService =
            CommunicationSocketIOService(conversationId: conversationId),
        super(const ConversationState()) {
    on<DataFetchedEvent>(
      _onDataFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<MessageSentEvent>(_onMessageSent);
    on<MessageTextInputChangedEvent>(_onMessageTextInputChanged);
    on<_NewMessageReceivedEvent>(_onNewMessageReceived);
    on<ConversationInfoFetchedEvent>(_onConversationInfoFetched);
    on<FilePicked>(_onFilesPicked);
    on<FilesCleared>(_onFilesCleared);

    _socketIOService.connect();

    _streamSubscription = _socketIOService.getResponse
        .listen((message) => add(_NewMessageReceivedEvent(message)));
  }

  late StreamSubscription<Message> _streamSubscription;
  final ConversationRepository _conversationRepository;
  final CommunicationSocketIOService _socketIOService;
  final String _conversationId;

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    _socketIOService.dispose();
    return super.close();
  }

  Future<void> _onConversationInfoFetched(
    ConversationInfoFetchedEvent event,
    Emitter<ConversationState> emit,
  ) async {
    emit(state.copyWith(headerStatus: FetchDataStatus.loading));

    try {
      final conversation =
          await _conversationRepository.getConversationById(_conversationId);

      emit(state.copyWith(
          conversationInfo: conversation,
          headerStatus: FetchDataStatus.success));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(headerStatus: FetchDataStatus.failure));
    }
  }

  Future<void> _onDataFetched(
      DataFetchedEvent event, Emitter<ConversationState> emit) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final messages = await _conversationRepository.fetchMessages(
          _conversationId, state.messages.length);

      messages.isEmpty ||
              (messages.length < messageLimit && state.messages.isEmpty)
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              messages: List.of(state.messages)..addAll(messages),
            ))
          : emit(state.copyWith(
              hasReachedMax: false,
              status: FetchDataStatus.success,
              messages: List.of(state.messages)..addAll(messages),
            ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onMessageSent(
    MessageSentEvent event,
    Emitter<ConversationState> emit,
  ) async {
    if (state.files.isNotEmpty) {
      emit(state.copyWith(showUploadingMessage: true));

      try {
        final uploadedUrls = await _conversationRepository.uploadMessageFiles(
            state.files.map((e) => e.path!).toList(),
            state.files[0].isImage
                ? EMessageMediaType.image.name
                : EMessageMediaType.video.name);

        _socketIOService.sendMessage(
            content: state.currentInputText.noBlank,
            images: state.files[0].isImage ? uploadedUrls : null,
            video: state.files[0].isImage ? null : uploadedUrls[0]);
      } catch (e) {
        logger.severe(e);
        emit(state.copyWith(showUploadingMessage: false));
      } finally {
        emit(state.copyWith(files: []));
      }
    } else {
      _socketIOService.sendMessage(content: state.currentInputText);
    }
  }

  void _onMessageTextInputChanged(
      MessageTextInputChangedEvent event, Emitter<ConversationState> emit) {
    emit(state.copyWith(currentInputText: event.text));
  }

  void _onNewMessageReceived(
    _NewMessageReceivedEvent event,
    Emitter<ConversationState> emit,
  ) {
    emit(state.copyWith(
      messages: List.of(state.messages)..insert(0, event.message),
      showUploadingMessage: false,
    ));
  }

  void _onFilesPicked(FilePicked event, Emitter<ConversationState> emit) {
    emit(state.copyWith(files: event.files));
  }

  void _onFilesCleared(FilesCleared event, Emitter<ConversationState> emit) {
    emit(state.copyWith(files: []));
  }
}

extension on PlatformFile {
  bool get isImage {
    return allowedImageExtensions.contains(extension);
  }
}
