part of 'received_mail_bloc.dart';

sealed class ReceivedMailEvent extends Equatable {
  const ReceivedMailEvent();

  @override
  List<Object> get props => [];
}

final class ReceiverFetchedEvent extends ReceivedMailEvent {
  const ReceiverFetchedEvent();

  @override
  List<Object> get props => [];
}

final class ReceiverResetEvent extends ReceivedMailEvent {
  const ReceiverResetEvent();

  @override
  List<Object> get props => [];
}
