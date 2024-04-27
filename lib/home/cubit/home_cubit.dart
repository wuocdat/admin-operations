import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const HomeState());

  final TaskRepository _taskRepository;

  void changeIndex(int index) => emit(state.copyWith(index: index));

  Future<void> checkUnreadTask() async {
    final taskOverall = await _taskRepository.getOverall();
    emit(state.copyWith(hasUnreadTask: taskOverall.unread > 0));
  }
}
