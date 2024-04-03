import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
      final tasks = await _taskRepository.getReceivedTasks();
      log("task $tasks");
      emit(state.copyWith(status: ReceiverStatus.success, tasks: tasks));
    } catch (e) {
      debugPrint('task error ${e.toString()}');
      emit(state.copyWith(status: ReceiverStatus.failure));
    }
  }

  void _onProgressStatusChanged(
      ProgressStatusChangedEvent event, Emitter<ReceiverState> emit) {
    emit(state.copyWith(progressStatus: event.status));
  }
}
