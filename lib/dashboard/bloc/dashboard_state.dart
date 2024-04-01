part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.task = TaskOverall.empty,
    this.status = DashboardStatus.initial,
  });

  final DashboardStatus status;
  final TaskOverall task;

  DashboardState copyWith({
    DashboardStatus? status,
    TaskOverall? task,
  }) {
    return DashboardState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [task];
}
