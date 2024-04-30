import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required TaskRepository taskRepository,
    required MailRepository mailRepository,
  })  : _taskRepository = taskRepository,
        _mailRepository = mailRepository,
        super(const DashboardState()) {
    on<TaskOverallSubscriptionRequested>(_onTaskOverallSubscriptionRequested);
    on<MailOverallSubscriptionRequested>(_onMailOverallSubscriptionRequested);
  }

  final TaskRepository _taskRepository;
  final MailRepository _mailRepository;

  Future<void> _onTaskOverallSubscriptionRequested(
    TaskOverallSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await emit.forEach<Overall>(
      _taskRepository.overall,
      onData: (overall) => state.copyWith(
        task: overall,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardStatus.failure,
      ),
    );
  }

  Future<void> _onMailOverallSubscriptionRequested(
    MailOverallSubscriptionRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await emit.forEach<MailOverall>(
      _mailRepository.overall,
      onData: (overall) => state.copyWith(
        mail: overall,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardStatus.failure,
      ),
    );
  }
}
