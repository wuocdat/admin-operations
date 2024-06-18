part of 'received_task_detail_cubit.dart';

enum ReportStatus { initial, detail, form }

class ReceivedTaskDetailState extends Equatable {
  const ReceivedTaskDetailState({
    this.currentTask = Task.empty,
    this.status = FetchDataStatus.initial,
    this.reportStatus = ReportStatus.initial,
  });

  final Task currentTask;
  final FetchDataStatus status;
  final ReportStatus reportStatus;

  ReceivedTaskDetailState copyWith({
    Task? currentTask,
    FetchDataStatus? status,
    ReportStatus? reportStatus,
  }) {
    return ReceivedTaskDetailState(
      currentTask: currentTask ?? this.currentTask,
      status: status ?? this.status,
      reportStatus: reportStatus ?? this.reportStatus,
    );
  }

  @override
  List<Object> get props => [currentTask, status, reportStatus];
}
