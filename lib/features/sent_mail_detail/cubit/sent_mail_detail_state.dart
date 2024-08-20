part of 'sent_mail_detail_cubit.dart';

class SentMailDetailState extends Equatable {
  const SentMailDetailState(
      {this.mail = SentMailType.empty, this.status = FetchDataStatus.initial});

  final FetchDataStatus status;
  final SentMailType mail;

  SentMailDetailState copyWith({
    FetchDataStatus? status,
    SentMailType? mail,
  }) {
    return SentMailDetailState(
        mail: mail ?? this.mail, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, mail];
}
