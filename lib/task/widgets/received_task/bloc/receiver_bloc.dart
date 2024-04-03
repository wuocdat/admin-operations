import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';

part 'receiver_event.dart';
part 'receiver_state.dart';

class ReceiverBloc extends Bloc<ReceiverEvent, ReceiverState> {
  ReceiverBloc({required TaskRepository repository})
      : _taskRepository = repository,
        super(const ReceiverState()) {
    on<ReceiverStartedEvent>(_onReceiverStated);
    on<ProgressStatusChangedEvent>(_onProgressStatusChanged);
  }

  final TaskRepository _taskRepository;

  Future<void> _onReceiverStated(
      ReceiverStartedEvent event, Emitter<ReceiverState> emit) async {
    emit(state.copyWith(status: ReceiverStatus.loading));

    try {
      final tasks =
          await _taskRepository.getReceivedTasks(state.progressStatus.query);
      emit(state.copyWith(status: ReceiverStatus.success, tasks: tasks));
    } catch (_) {
      emit(state.copyWith(status: ReceiverStatus.failure));
    }
  }

  Future<void> _onProgressStatusChanged(
      ProgressStatusChangedEvent event, Emitter<ReceiverState> emit) async {
    emit(state.copyWith(
        progressStatus: event.status, status: ReceiverStatus.loading));

    try {
      final tasks = await _taskRepository.getReceivedTasks(event.status.query);
      emit(state.copyWith(status: ReceiverStatus.success, tasks: tasks));
    } catch (_) {
      emit(state.copyWith(
          status: ReceiverStatus.failure, tasks: List<Task>.empty()));
    }
  }
}

extension on TaskProgressStatus {
  String get query {
    switch (this) {
      case TaskProgressStatus.all:
        return "all";
      case TaskProgressStatus.unread:
        return "unread";
      case TaskProgressStatus.unfinished:
        return "unfinish";
    }
  }
}
