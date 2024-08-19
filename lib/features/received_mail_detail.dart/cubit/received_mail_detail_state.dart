part of 'received_mail_detail_cubit.dart';

class ReceivedMailDetailState extends Equatable {
  const ReceivedMailDetailState(
      {this.mail = Mail.empty, this.status = FetchDataStatus.initial});

  final FetchDataStatus status;
  final Mail mail;

  ReceivedMailDetailState copyWith({
    FetchDataStatus? status,
    Mail? mail,
  }) {
    return ReceivedMailDetailState(
        mail: mail ?? this.mail, status: status ?? this.status);
  }

  @override
  List<Object> get props => [status, mail];
}
