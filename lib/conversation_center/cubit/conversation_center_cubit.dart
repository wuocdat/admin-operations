import 'package:bloc/bloc.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'conversation_center_state.dart';

class ConversationCenterCubit extends Cubit<ConversationCenterState> {
  ConversationCenterCubit({
    required ConversationRepository conversationRepository,
  })  : _conversationRepository = conversationRepository,
        super(const ConversationCenterState());

  final ConversationRepository _conversationRepository;

  Future<void> fetchConversations() async {
    try {
      emit(state.copyWith(status: FetchDataStatus.loading));

      final conversations = await _conversationRepository.getConversations();

      emit(state.copyWith(
          status: FetchDataStatus.success, conversations: conversations));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
