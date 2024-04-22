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

  String get id {
    switch (this) {
      case TaskType.report:
        return '1';
      case TaskType.investigate:
        return '2';
      case TaskType.monitor:
        return '3';
      case TaskType.other:
        return '0';
    }
  }
}

class NewTaskState extends Equatable {
  const NewTaskState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.units = const <String>[],
    this.childrenUnits = const <Unit>[],
    this.type = TaskType.report,
    this.important = false,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.fetchDataStatus = FetchDataStatus.initial,
    this.files = const [],
  });

  final Title title;
  final Content content;
  final List<String> units;
  final List<Unit> childrenUnits;
  final TaskType type;
  final bool important;
  final FormzSubmissionStatus status;
  final bool isValid;
  final FetchDataStatus fetchDataStatus;
  final List<PlatformFile> files;

  NewTaskState copyWith({
    Title? title,
    Content? content,
    List<String>? units,
    List<Unit>? childrenUnits,
    TaskType? type,
    bool? important,
    FormzSubmissionStatus? status,
    bool? isValid,
    FetchDataStatus? fetchDataStatus,
    List<PlatformFile>? files,
  }) {
    return NewTaskState(
      title: title ?? this.title,
      content: content ?? this.content,
      units: units ?? this.units,
      childrenUnits: childrenUnits ?? this.childrenUnits,
      type: type ?? this.type,
      important: important ?? this.important,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      fetchDataStatus: fetchDataStatus ?? this.fetchDataStatus,
      files: files ?? this.files,
    );
  }

  @override
  List<Object> get props => [
        title,
        content,
        units,
        type,
        important,
        status,
        isValid,
        childrenUnits,
        fetchDataStatus,
        files,
      ];
}
