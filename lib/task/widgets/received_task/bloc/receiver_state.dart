part of 'receiver_bloc.dart';

enum ReceiverStatus { initial, loading, success, failure }

class ReceiverState extends Equatable {
  const ReceiverState({
    this.status = ReceiverStatus.initial,
    this.tasks = const <Task>[],
  });

  final ReceiverStatus status;
  final List<Task> tasks;

  ReceiverState copyWith({
    ReceiverStatus? status,
    List<Task>? tasks,
  }) {
    return ReceiverState(
      status: status ?? this.status,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object> get props => [status, tasks];
}
