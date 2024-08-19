part of 'sent_mail_bloc.dart';

sealed class SentMailEvent extends Equatable {
  const SentMailEvent();

  @override
  List<Object> get props => [];
}

final class SentMailsFetchedEvent extends SentMailEvent {
  const SentMailsFetchedEvent();

  @override
  List<Object> get props => [];
}

final class SentMailsResetEvent extends SentMailEvent {
  const SentMailsResetEvent();

  @override
  List<Object> get props => [];
}
