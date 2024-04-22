part of 'sent_task_detail_cubit.dart';

class SentTaskDetailState extends Equatable {
  const SentTaskDetailState({
    this.currentTask = Task.empty,
    this.status = FetchDataStatus.initial,
  });

  final Task currentTask;
  final FetchDataStatus status;

  SentTaskDetailState copyWith({
    Task? currentTask,
    FetchDataStatus? status,
  }) {
    return SentTaskDetailState(
      currentTask: currentTask ?? this.currentTask,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [currentTask, status];
}
