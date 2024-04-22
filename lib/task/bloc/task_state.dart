part of 'task_bloc.dart';

enum TaskOptions { receivedTask, sentTask }

final class TaskState extends Equatable {
  const TaskState._({
    this.mode = TaskOptions.receivedTask,
    this.searchValue = "",
    this.reloadCount = 0,
  });

  const TaskState.receiver() : this._();

  const TaskState.sender() : this._(mode: TaskOptions.sentTask);

  final TaskOptions mode;
  final String searchValue;
  final int reloadCount;

  TaskState copyWith({
    TaskOptions? mode,
    String? searchValue,
    int? reloadCount,
  }) {
    return TaskState._(
      mode: mode ?? this.mode,
      searchValue: searchValue ?? this.searchValue,
      reloadCount: reloadCount ?? this.reloadCount,
    );
  }

  @override
  List<Object> get props => [mode, searchValue, reloadCount];
}
