part of 'mail_container_bloc.dart';

sealed class MailContainerEvent extends Equatable {
  const MailContainerEvent();

  @override
  List<Object> get props => [];
}

final class ChangeModeEvent extends MailContainerEvent {
  const ChangeModeEvent({required this.mode});

  final MailOptions mode;

  @override
  List<Object> get props => [mode];
}
