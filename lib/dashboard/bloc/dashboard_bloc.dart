import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart' hide Overall;
import 'package:tctt_mobile/dashboard/models/task_overall.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required TaskRepository taskRepository})
      : _taskRepository = taskRepository,
        super(const DashboardState()) {
    on<DashboardStartupEvent>(_onStartUp);
  }

  final TaskRepository _taskRepository;

  Future<void> _onStartUp(
    DashboardStartupEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      final task = await _taskRepository.getOverall();

      emit(state.copyWith(
        status: DashboardStatus.success,
        task: TaskOverall(
          all: task.all,
          finished: task.finished,
          unfinished: task.unfinished,
          unread: task.unread,
        ),
      ));
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }
}
