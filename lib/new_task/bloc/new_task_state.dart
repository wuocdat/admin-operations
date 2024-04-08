part of 'new_task_bloc.dart';

enum TaskType { report, investigate, monitor, other }

extension TaskTypeX on TaskType {
  String get name {
    switch (this) {
      case TaskType.report:
        return 'Báo xấu';
      case TaskType.investigate:
        return 'Điều tra';
      case TaskType.monitor:
        return 'Giám sát';
      case TaskType.other:
        return 'Khác';
    }
  }
}

class NewTaskState extends Equatable {
  const NewTaskState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.units = const <String>[],
    this.type = TaskType.report,
    this.important = false,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });

  final Title title;
  final Content content;
  final List<String> units;
  final TaskType type;
  final bool important;
  final FormzSubmissionStatus status;
  final bool isValid;

  NewTaskState copyWith({
    Title? title,
    Content? content,
    List<String>? units,
    TaskType? type,
    bool? important,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return NewTaskState(
      title: title ?? this.title,
      content: content ?? this.content,
      units: units ?? this.units,
      type: type ?? this.type,
      important: important ?? this.important,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [title, content, units, type, important, status, isValid];
}
