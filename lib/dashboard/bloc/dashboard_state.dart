part of 'dashboard_bloc.dart';

enum DashboardStatus { initial, loading, success, failure }

class DashboardState extends Equatable {
  const DashboardState({
    this.task = Overall.empty,
    this.status = DashboardStatus.initial,
  });

  final DashboardStatus status;
  final Overall task;

  DashboardState copyWith({
    DashboardStatus? status,
    Overall? task,
  }) {
    return DashboardState(
      status: status ?? this.status,
      task: task ?? this.task,
    );
  }

  @override
  List<Object> get props => [task];
}
