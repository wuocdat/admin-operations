part of 'new_task_bloc.dart';

class NewTaskState extends Equatable {
  const NewTaskState({
    this.title = const Title.pure(),
    this.content = const Content.pure(),
    this.units = const <String>[],
    this.childrenUnits = const <Unit>[],
    this.type = TaskTypeE.report,
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
  final TaskTypeE type;
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
    TaskTypeE? type,
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
