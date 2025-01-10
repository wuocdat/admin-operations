import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:target_repository/target_repository.dart';
import 'package:task_repository/task_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required TaskRepository taskRepository,
    required MailRepository mailRepository,
    required TargetRepository targetRepository,
  })  : _taskRepository = taskRepository,
        _mailRepository = mailRepository,
        _targetRepository = targetRepository,
        super(const DashboardState()) {
    on<TaskOverallSubscriptionRequested>(_onTaskOverallSubscriptionRequested);
    on<MailOverallSubscriptionRequested>(_onMailOverallSubscriptionRequested);
    on<OverallsReloaded>(_onOverallsReloaded);
  }

  final TaskRepository _taskRepository;
  final MailRepository _mailRepository;
  final TargetRepository _targetRepository;

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
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final newestMail = await _mailRepository.getNewestMail();
      final targetOverall = await _targetRepository.getOverall();
      final postOverall = await _targetRepository.getPostOverall();

      emit(state.copyWith(
        newestMail: newestMail,
        target: targetOverall,
        postData: postOverall,
        status: DashboardStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }

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

  Future<void> _onOverallsReloaded(
    OverallsReloaded event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: DashboardStatus.loading));
    try {
      final newestMail = await _mailRepository.getNewestMail();
      final targetOverall = await _targetRepository.getOverall();
      final postOverall = await _targetRepository.getPostOverall();

      emit(state.copyWith(
        newestMail: newestMail,
        target: targetOverall,
        postData: postOverall,
        status: DashboardStatus.success,
      ));
    } catch (_) {
      emit(state.copyWith(status: DashboardStatus.failure));
    }
  }
}
