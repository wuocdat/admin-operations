import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'conversation_center_state.dart';

class ConversationCenterCubit extends Cubit<ConversationCenterState> {
  ConversationCenterCubit({
    required ConversationRepository conversationRepository,
  })  : _conversationRepository = conversationRepository,
        super(const ConversationCenterState()) {

    //should have debounce
    _conversationSubscription = _conversationRepository.notification
        .listen((_) => fetchConversations(true));
  }

  final ConversationRepository _conversationRepository;
  late StreamSubscription<String> _conversationSubscription;

  Future<void> fetchConversations([bool withoutLoading = false]) async {
    try {
      if (!withoutLoading) emit(state.copyWith(status: FetchDataStatus.loading));

      final conversations = await _conversationRepository.getConversations();

      emit(state.copyWith(
          status: FetchDataStatus.success, conversations: conversations));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  @override
  Future<void> close() {
    _conversationSubscription.cancel();
    return super.close();
  }
}
