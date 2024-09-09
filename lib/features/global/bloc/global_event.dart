part of 'global_bloc.dart';

sealed class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

final class AppNavigatedOnLaunchEvent extends GlobalEvent {
  const AppNavigatedOnLaunchEvent();

  @override
  List<Object> get props => [];
}

final class ConversationDataPushedEvent extends GlobalEvent {
  const ConversationDataPushedEvent(this.conversationId);

  final String conversationId;

  @override
  List<Object> get props => [conversationId];
}

final class TaskOverallUpdatedEvent extends GlobalEvent {
  const TaskOverallUpdatedEvent();

  @override
  List<Object> get props => [];
}

final class MailOverallUpdatedEvent extends GlobalEvent {
  const MailOverallUpdatedEvent();

  @override
  List<Object> get props => [];
}
