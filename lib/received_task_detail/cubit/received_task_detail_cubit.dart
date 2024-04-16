import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'received_task_detail_state.dart';

class ReceivedTaskDetailCubit extends Cubit<ReceivedTaskDetailState> {
  ReceivedTaskDetailCubit(this._taskRepository)
      : super(const ReceivedTaskDetailState());

  final TaskRepository _taskRepository;

  Future<void> fetchTask(String taskId) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final taskDetail = await _taskRepository.fetchReceivedTaskById(taskId);

      emit(state.copyWith(
        currentTask: taskDetail,
        status: FetchDataStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
