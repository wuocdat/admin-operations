part of 'sent_mail_bloc.dart';

class SentMailState extends Equatable {
  const SentMailState({
    this.hasReachedMax = false,
    this.mails = const [],
    this.status = FetchDataStatus.initial,
  });

  final FetchDataStatus status;
  final List<SentMailType> mails;
  final bool hasReachedMax;

  SentMailState copyWith({
    FetchDataStatus? status,
    List<SentMailType>? mails,
    bool? hasReachedMax,
  }) {
    return SentMailState(
      status: status ?? this.status,
      mails: mails ?? this.mails,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, mails, hasReachedMax];
}
