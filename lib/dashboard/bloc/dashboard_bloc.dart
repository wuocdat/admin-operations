import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_repository/task_repository.dart';

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
    emit(state.copyWith(status: DashboardStatus.loading));

    await emit.forEach<Overall>(
      _taskRepository.overall,
      onData: (overall) => state.copyWith(
        status: DashboardStatus.success,
        task: overall,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardStatus.failure,
      ),
    );
  }
}
