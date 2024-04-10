part of 'new_task_bloc.dart';

sealed class NewTaskEvent extends Equatable {
  const NewTaskEvent();

  @override
  List<Object> get props => [];
}

final class NewTaskStarted extends NewTaskEvent {
  const NewTaskStarted({required this.unitId});

  final String unitId;

  @override
  List<Object> get props => [unitId];
}

final class TitleChanged extends NewTaskEvent {
  const TitleChanged(this.title);

  final String title;

  @override
  List<Object> get props => [title];
}

final class ContentChanged extends NewTaskEvent {
  const ContentChanged(this.content);

  final String content;

  @override
  List<Object> get props => [content];
}

final class UnitsChanged extends NewTaskEvent {
  const UnitsChanged({required this.unit, required this.checked});

  final String unit;
  final bool checked;

  @override
  List<Object> get props => [unit, checked];
}

final class TypeChanged extends NewTaskEvent {
  const TypeChanged(this.type);

  final TaskType type;

  @override
  List<Object> get props => [type];
}

final class ImportantToggled extends NewTaskEvent {
  const ImportantToggled();

  @override
  List<Object> get props => [];
}

final class NewTaskSubmitted extends NewTaskEvent {
  const NewTaskSubmitted();

  @override
  List<Object> get props => [];
}

final class FilePicked extends NewTaskEvent {
  const FilePicked(this.files);

  final List<PlatformFile> files;

  @override
  List<Object> get props => [files];
}
