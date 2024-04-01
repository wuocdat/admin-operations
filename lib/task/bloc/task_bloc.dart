import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState.receiver()) {
    on<ChangeModeEvent>(_onChangeMode);
    on<ChangeSearchInputEvent>(_onSearchInputChange);
  }

  void _onChangeMode(ChangeModeEvent event, Emitter<TaskState> emit) {
    emit(event.mode.isReceiverMode
        ? const TaskState.receiver()
        : const TaskState.sender());
  }

  void _onSearchInputChange(
      ChangeSearchInputEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(searchValue: event.searchValue));
  }
}

extension on TaskOptions {
  bool get isReceiverMode => this == TaskOptions.receivedTask;
}
