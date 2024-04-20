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
        reportStatus: switch (taskDetail.progress?.repeat) {
          null => ReportStatus.initial,
          0 => ReportStatus.form,
          _ => ReportStatus.detail,
        },
      ));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  void reportAgain() {
    if ((state.currentTask.progress?.repeat ?? 0) < 3) {
      emit(state.copyWith(reportStatus: ReportStatus.form));
    }
  }

  void closeFormMode() {
    if (state.currentTask.progress?.repeat != 0) {
      emit(state.copyWith(reportStatus: ReportStatus.detail));
    }
  }
}
