part of 'receiver_bloc.dart';

enum ReceiverStatus { initial, loading, success, failure }

enum TaskProgressStatus { all, unread, unfinished }

extension TaskProgressStatusX on TaskProgressStatus {
  String get title {
    switch (this) {
      case TaskProgressStatus.all:
        return "Tất cả";
      case TaskProgressStatus.unread:
        return "Chưa đọc";
      case TaskProgressStatus.unfinished:
        return "Chưa báo cáo";
    }
  }
}

class ReceiverState extends Equatable {
  const ReceiverState({
    this.status = ReceiverStatus.initial,
    this.tasks = const <Task>[],
    this.progressStatus = TaskProgressStatus.all,
  });

  final TaskProgressStatus progressStatus;
  final ReceiverStatus status;
  final List<Task> tasks;

  ReceiverState copyWith({
    ReceiverStatus? status,
    List<Task>? tasks,
    TaskProgressStatus? progressStatus,
  }) {
    return ReceiverState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      progressStatus: progressStatus ?? this.progressStatus,
    );
  }

  @override
  List<Object> get props => [status, tasks, progressStatus];
}
