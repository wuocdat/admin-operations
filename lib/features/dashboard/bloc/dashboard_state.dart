part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.task = Overall.empty,
    this.mail = MailOverall.empty,
    this.target = TargetOverall.empty,
    this.postData = PostOverall.empty,
    this.status = DashboardStatus.initial,
    this.newestMail,
  });

  final DashboardStatus status;
  final Overall task;
  final MailOverall mail;
  final TargetOverall target;
  final PostOverall postData;
  final Mail? newestMail;

  DashboardState copyWith({
    DashboardStatus? status,
    Overall? task,
    MailOverall? mail,
    TargetOverall? target,
    PostOverall? postData,
    Mail? newestMail,
  }) {
    return DashboardState(
      status: status ?? this.status,
      task: task ?? this.task,
      mail: mail ?? this.mail,
      newestMail: newestMail ?? this.newestMail,
      target: target ?? this.target,
      postData: postData ?? this.postData,
    );
  }

  @override
  List<Object?> get props => [task, status, mail, newestMail, target, postData];
}
