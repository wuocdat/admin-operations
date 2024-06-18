import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';

part 'sender_event.dart';
part 'sender_state.dart';

class SenderBloc extends Bloc<SenderEvent, SenderState> {
  SenderBloc({required TaskRepository repository})
      : _taskRepository = repository,
        super(const SenderState()) {
    on<SenderFetchedEvent>(
      _onSenderFetched,
      transformer: throttleDroppable(throttleDuration),
    );
    on<SearchInputChangedEvent>(
      _onSearchInputChanged,
      transformer: debounce(debounceDuration),
    );
    on<OwnerChangedEvent>(_onOwnerChanged);
    on<SentTaskRefetched>(_onTaskRefetched);
  }

  final TaskRepository _taskRepository;

  Future<void> _onSenderFetched(
    SenderFetchedEvent event,
    Emitter<SenderState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final tasks = await _taskRepository.fetchSentTasks(
        state.owner.query,
        state.searchValue,
        state.tasks.length,
      );

      tasks.length < taskLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              tasks: List.of(state.tasks)..addAll(tasks),
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              tasks: List.of(state.tasks)..addAll(tasks),
            ));
    } catch (e) {
      log(e.toString());
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onOwnerChanged(
    OwnerChangedEvent event,
    Emitter<SenderState> emit,
  ) async {
    emit(
      state.copyWith(
          owner: event.owner,
          status: FetchDataStatus.loading,
          tasks: List<Task>.empty()),
    );

    try {
      final tasks = await _taskRepository.fetchSentTasks(
          event.owner.query, state.searchValue);
      emit(state.copyWith(
        status: FetchDataStatus.success,
        tasks: tasks,
        hasReachedMax: tasks.length < taskLimit,
      ));
    } catch (_) {
      emit(state.copyWith(
          status: FetchDataStatus.failure, tasks: List<Task>.empty()));
    }
  }

  Future<void> _onSearchInputChanged(
      SearchInputChangedEvent event, Emitter<SenderState> emit) async {
    emit(state.copyWith(
        searchValue: event.searchValue,
        status: FetchDataStatus.loading,
        tasks: List<Task>.empty()));

    try {
      final tasks = await _taskRepository.fetchSentTasks(
          state.owner.query, event.searchValue);
      emit(state.copyWith(
          status: FetchDataStatus.success,
          tasks: tasks,
          hasReachedMax: tasks.length < taskLimit));
    } catch (_) {
      emit(state.copyWith(
        status: FetchDataStatus.failure,
        tasks: List<Task>.empty(),
      ));
    }
  }

  Future<void> _onTaskRefetched(
    SentTaskRefetched event,
    Emitter<SenderState> emit,
  ) async {
    emit(state.copyWith(
        status: FetchDataStatus.loading, tasks: List<Task>.empty()));

    try {
      final tasks = await _taskRepository.fetchSentTasks(
          state.owner.query, state.searchValue);
      emit(state.copyWith(
        status: FetchDataStatus.success,
        tasks: tasks,
        hasReachedMax: tasks.length < taskLimit,
      ));
    } catch (_) {
      emit(state.copyWith(
          status: FetchDataStatus.failure, tasks: List<Task>.empty()));
    }
  }
}
