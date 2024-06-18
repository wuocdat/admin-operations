part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

final class TaskOverallSubscriptionRequested extends DashboardEvent {
  const TaskOverallSubscriptionRequested();
}

final class MailOverallSubscriptionRequested extends DashboardEvent {
  const MailOverallSubscriptionRequested();
}

final class OverallsReloaded extends DashboardEvent {
  const OverallsReloaded();
}
