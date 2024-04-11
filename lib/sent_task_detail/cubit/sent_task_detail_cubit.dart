import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'sent_task_detail_state.dart';

class SentTaskDetailCubit extends Cubit<SentTaskDetailState> {
  SentTaskDetailCubit(this._taskRepository)
      : super(const SentTaskDetailState());

  final TaskRepository _taskRepository;

  Future<void> fetchTask(String taskId) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final taskDetail = await _taskRepository.fetchSentTaskById(taskId);

      emit(state.copyWith(
        currentTask: taskDetail,
        status: FetchDataStatus.success,
      ));
    } catch (e) {
      debugPrint('taskDetail: ${e.toString()}');
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
