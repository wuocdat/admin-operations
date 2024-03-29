import 'package:equatable/equatable.dart';

class Overall extends Equatable {
  const Overall({
    required this.all,
    required this.finished,
    required this.unfinished,
    required this.unread,
  });

  final int all;
  final int finished;
  final int unfinished;
  final int unread;

  @override
  List<Object> get props => [all, finished, unfinished, unread];
}
