import 'package:bloc/bloc.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc({required ConversationRepository conversationRepository})
      : _conversationRepository = conversationRepository,
        super(const GlobalState()) {
    on<AppNavigatedOnLaunchEvent>(_onAppNavigatedOnLaunch);
    on<ConversationDataPushedEvent>(_onConversationDataPushed);
  }

  final ConversationRepository _conversationRepository;

  void _onAppNavigatedOnLaunch(
      AppNavigatedOnLaunchEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(hasNavigatedOnLaunchApp: true));
  }

  void _onConversationDataPushed(
      ConversationDataPushedEvent event, Emitter<GlobalState> emit) {
    _conversationRepository.pushConversationDataToStream(event.conversationId);
  }
}
