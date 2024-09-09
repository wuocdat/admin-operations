import 'package:bloc/bloc.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/core/utils/logger.dart';

part 'global_event.dart';

part 'global_state.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc({
    required ConversationRepository conversationRepository,
    required TaskRepository taskRepository,
    required MailRepository mailRepository,
  })  : _conversationRepository = conversationRepository,
        _taskRepository = taskRepository,
        _mailRepository = mailRepository,
        super(const GlobalState()) {
    on<AppNavigatedOnLaunchEvent>(_onAppNavigatedOnLaunch);
    on<ConversationDataPushedEvent>(_onConversationDataPushed);
    on<TaskOverallUpdatedEvent>(_onTaskOverallUpdated);
    on<MailOverallUpdatedEvent>(_onMailOverallUpdated);
  }

  final ConversationRepository _conversationRepository;
  final TaskRepository _taskRepository;
  final MailRepository _mailRepository;

  void _onAppNavigatedOnLaunch(
      AppNavigatedOnLaunchEvent event, Emitter<GlobalState> emit) {
    emit(state.copyWith(hasNavigatedOnLaunchApp: true));
  }

  void _onConversationDataPushed(
      ConversationDataPushedEvent event, Emitter<GlobalState> emit) {
    _conversationRepository.pushConversationDataToStream(event.conversationId);
  }

  Future<void> _onTaskOverallUpdated(
      TaskOverallUpdatedEvent event, Emitter<GlobalState> emit) async {
    try {
      await _taskRepository.updateOverall();
    } catch (e) {
      logger.severe(e);
    }
  }

  Future<void> _onMailOverallUpdated(
      MailOverallUpdatedEvent event, Emitter<GlobalState> emit) async {
    try {
      await _mailRepository.updateOverall();
    } catch (e) {
      logger.severe(e);
    }
  }
}
