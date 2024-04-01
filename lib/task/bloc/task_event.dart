part of 'task_bloc.dart';

sealed class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

final class ChangeModeEvent extends TaskEvent {
  const ChangeModeEvent({required this.mode});

  final TaskOptions mode;

  @override
  List<Object> get props => [mode];
}

final class ChangeSearchInputEvent extends TaskEvent {
  const ChangeSearchInputEvent(this.searchValue);

  final String searchValue;

  @override
  List<Object> get props => [searchValue];
}
