part of 'new_mail_cubit.dart';

class NewMailState extends Equatable {
  const NewMailState({
    this.title = const Content.pure(),
    this.content = const Content.pure(),
    this.units = const <String>[],
    this.unitNodes = const <UnitNode>[],
    this.important = false,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.fetchDataStatus = FetchDataStatus.initial,
    this.files = const [],
  });

  final Content title;
  final Content content;
  final List<String> units;
  final List<UnitNode> unitNodes;
  final bool important;
  final FormzSubmissionStatus status;
  final bool isValid;
  final FetchDataStatus fetchDataStatus;
  final List<PlatformFile> files;

  NewMailState copyWith({
    Content? title,
    Content? content,
    List<String>? units,
    List<UnitNode>? unitNodes,
    bool? important,
    FormzSubmissionStatus? status,
    bool? isValid,
    FetchDataStatus? fetchDataStatus,
    List<PlatformFile>? files,
  }) {
    return NewMailState(
      title: title ?? this.title,
      content: content ?? this.content,
      units: units ?? this.units,
      unitNodes: unitNodes ?? this.unitNodes,
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
        important,
        status,
        isValid,
        unitNodes,
        fetchDataStatus,
        files,
      ];
}
