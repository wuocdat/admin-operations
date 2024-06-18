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
      final statistic = await _taskRepository.fetchStatistic(taskId);

      emit(state.copyWith(
        currentTask: taskDetail,
        status: FetchDataStatus.success,
        statistic: statistic,
      ));
    } catch (e) {
      debugPrint('taskDetail: ${e.toString()}');
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> withDrawTask(String taskId) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      await _taskRepository.withDrawTask(taskId);
      emit(state.copyWith(
          status: FetchDataStatus.success,
          currentTask: state.currentTask.copyWith(disable: true)));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  void changeUnit(String unitId) {
    emit(state.copyWith(
      progresses: List.empty(),
      hasReachedMax: false,
    ));

    fetchProgresses(state.currentTask.id, unitId);
  }

  Future<void> fetchProgresses(String taskId, String unitId) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final progresses = await _taskRepository.fetchTaskProgresses(
          taskId, unitId, state.progresses.length);

      progresses.length < progressLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              progresses: List.of(state.progresses)..addAll(progresses),
              status: FetchDataStatus.success,
            ))
          : emit(state.copyWith(
              progresses: List.of(state.progresses)..addAll(progresses),
              status: FetchDataStatus.success,
            ));
    } catch (e) {
      debugPrint('progresses: ${e.toString()}');
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
