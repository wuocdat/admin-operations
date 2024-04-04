import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState.receiver()) {
    on<ChangeModeEvent>(_onChangeMode);
    on<ChangeSearchInputEvent>(_onSearchInputChange);
    on<InputClosedEvent>(_onInputClosed);
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

  void _onInputClosed(InputClosedEvent event, Emitter<TaskState> emit) {
    emit(state.copyWith(searchValue: ""));
  }
}

extension TaskOptionsX on TaskOptions {
  String get title {
    if (this == TaskOptions.receivedTask) {
      return "Nhận nhiệm vụ";
    } else {
      return "Giao nhiệm vụ";
    }
  }

  bool get isReceiverMode => this == TaskOptions.receivedTask;
}
