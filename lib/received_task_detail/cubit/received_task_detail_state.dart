part of 'received_task_detail_cubit.dart';

class ReceivedTaskDetailState extends Equatable {
  const ReceivedTaskDetailState({
    this.currentTask = Task.empty,
    this.status = FetchDataStatus.initial,
  });

  final Task currentTask;
  final FetchDataStatus status;

  ReceivedTaskDetailState copyWith({
    Task? currentTask,
    FetchDataStatus? status,
  }) {
    return ReceivedTaskDetailState(
      currentTask: currentTask ?? this.currentTask,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [currentTask, status];
}
