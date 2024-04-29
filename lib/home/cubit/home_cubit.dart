import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const HomeState()) {
    _overallSubscription = _taskRepository.overall.listen(
        (overall) => emit(state.copyWith(unReadTaskNum: overall.unread)));
  }

  final TaskRepository _taskRepository;
  late StreamSubscription<Overall> _overallSubscription;

  @override
  Future<void> close() {
    _overallSubscription.cancel();
    return super.close();
  }

  void changeIndex(int index) => emit(state.copyWith(index: index));
}
