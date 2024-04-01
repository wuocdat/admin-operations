import 'package:equatable/equatable.dart';

class TaskOverall extends Equatable {
  const TaskOverall({
    required this.all,
    required this.finished,
    required this.unfinished,
    required this.unread,
  });

  final int all;
  final int finished;
  final int unfinished;
  final int unread;

  static const empty = TaskOverall(
    all: 0,
    finished: 0,
    unfinished: 0,
    unread: 0,
  );

  @override
  List<Object> get props => [all, finished, unfinished, unread];
}
