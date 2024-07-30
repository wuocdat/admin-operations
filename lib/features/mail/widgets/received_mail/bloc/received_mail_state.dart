part of 'received_mail_bloc.dart';

class ReceivedMailState extends Equatable {
  const ReceivedMailState({
    this.hasReachedMax = false,
    this.mails = const [],
    this.status = FetchDataStatus.initial,
  });

  final FetchDataStatus status;
  final List<Mail> mails;
  final bool hasReachedMax;

  ReceivedMailState copyWith({
    FetchDataStatus? status,
    List<Mail>? mails,
    bool? hasReachedMax,
  }) {
    return ReceivedMailState(
      status: status ?? this.status,
      mails: mails ?? this.mails,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, mails, hasReachedMax];
}
