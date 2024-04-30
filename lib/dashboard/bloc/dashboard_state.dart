part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.task = Overall.empty,
    this.mail = MailOverall.empty,
    this.status = DashboardStatus.initial,
  });

  final DashboardStatus status;
  final Overall task;
  final MailOverall mail;

  DashboardState copyWith({
    DashboardStatus? status,
    Overall? task,
    MailOverall? mail,
  }) {
    return DashboardState(
      status: status ?? this.status,
      task: task ?? this.task,
      mail: mail ?? this.mail,
    );
  }

  @override
  List<Object> get props => [task, status, mail];
}
