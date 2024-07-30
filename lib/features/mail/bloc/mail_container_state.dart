part of 'mail_container_bloc.dart';

enum MailOptions { receivedMail, sentMail }

class MailContainerState extends Equatable {
  const MailContainerState._({
    this.mode = MailOptions.receivedMail,
    this.searchValue = "",
    this.reloadCount = 0,
  });

  const MailContainerState.receiver() : this._();

  const MailContainerState.sender() : this._(mode: MailOptions.sentMail);

  final MailOptions mode;
  final String searchValue;
  final int reloadCount;

  MailContainerState copyWith({
    MailOptions? mode,
    String? searchValue,
    int? reloadCount,
  }) {
    return MailContainerState._(
      mode: mode ?? this.mode,
      searchValue: searchValue ?? this.searchValue,
      reloadCount: reloadCount ?? this.reloadCount,
    );
  }

  @override
  List<Object> get props => [mode, searchValue, reloadCount];
}
