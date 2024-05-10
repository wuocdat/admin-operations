part of 'new_subject_bloc.dart';

sealed class NewSubjectEvent extends Equatable {
  const NewSubjectEvent();

  @override
  List<Object> get props => [];
}

final class NameChangedEvent extends NewSubjectEvent {
  const NameChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class UidChangedEvent extends NewSubjectEvent {
  const UidChangedEvent(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class FbPageTypeChangedEvent extends NewSubjectEvent {
  const FbPageTypeChangedEvent(this.type);

  final FbPageType type;

  @override
  List<Object> get props => [type];
}

final class NewSubjectSubmitted extends NewSubjectEvent {
  const NewSubjectSubmitted();

  @override
  List<Object> get props => [];
}
