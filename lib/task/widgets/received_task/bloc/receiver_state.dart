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
    this.hasReachedMax = false,
    this.searchValue,
  });

  final TaskProgressStatus progressStatus;
  final String? searchValue;
  final ReceiverStatus status;
  final List<Task> tasks;
  final bool hasReachedMax;

  ReceiverState copyWith({
    ReceiverStatus? status,
    List<Task>? tasks,
    TaskProgressStatus? progressStatus,
    bool? hasReachedMax,
    String? searchValue,
  }) {
    return ReceiverState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
      progressStatus: progressStatus ?? this.progressStatus,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      searchValue: searchValue ?? this.searchValue,
    );
  }

  @override
  List<Object?> get props => [
        status,
        tasks,
        progressStatus,
        hasReachedMax,
        searchValue,
      ];
}
