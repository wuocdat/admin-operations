part of 'sent_task_detail_cubit.dart';

class SentTaskDetailState extends Equatable {
  const SentTaskDetailState({
    this.currentTask = Task.empty,
    this.status = FetchDataStatus.initial,
    this.statistic,
    this.progresses = const [],
    this.hasReachedMax = false,
  });

  final Task currentTask;
  final FetchDataStatus status;
  final Statistic? statistic;
  final List<ProgressDetail> progresses;
  final bool hasReachedMax;

  SentTaskDetailState copyWith({
    Task? currentTask,
    FetchDataStatus? status,
    Statistic? statistic,
    List<ProgressDetail>? progresses,
    bool? hasReachedMax,
  }) {
    return SentTaskDetailState(
      currentTask: currentTask ?? this.currentTask,
      status: status ?? this.status,
      statistic: statistic ?? this.statistic,
      progresses: progresses ?? this.progresses,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [
        currentTask,
        status,
        statistic,
        progresses,
        hasReachedMax,
      ];
}
