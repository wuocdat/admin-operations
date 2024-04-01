part of 'task_bloc.dart';

enum TaskOptions { receivedTask, sentTask }

final class TaskState extends Equatable {
  const TaskState._({
    this.mode = TaskOptions.receivedTask,
    this.searchValue = "",
    this.isSearchMode = false,
  });

  const TaskState.receiver() : this._();

  const TaskState.sender() : this._(mode: TaskOptions.sentTask);

  final TaskOptions mode;
  final String searchValue;
  final bool isSearchMode;

  TaskState copyWith({
    TaskOptions? mode,
    String? searchValue,
    bool? isSearchMode,
  }) {
    return TaskState._(
      mode: mode ?? this.mode,
      searchValue: searchValue ?? this.searchValue,
      isSearchMode: isSearchMode ?? this.isSearchMode,
    );
  }

  @override
  List<Object> get props => [mode, searchValue, isSearchMode];
}
