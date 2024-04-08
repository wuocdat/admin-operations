import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/new_task/models/models.dart';

part 'new_task_event.dart';
part 'new_task_state.dart';

class NewTaskBloc extends Bloc<NewTaskEvent, NewTaskState> {
  NewTaskBloc() : super(const NewTaskState()) {
    on<TitleChanged>(_onTitleChanged);
    on<ContentChanged>(_onContentChanged);
    on<UnitsChanged>(_onUnitsChanged);
    on<TypeChanged>(_onTaskTypeChanged);
    on<ImportantToggled>(_onImportantToggled);
    on<NewTaskSubmitted>(_onNewTaskSubmitted);
  }

  void _onTitleChanged(TitleChanged event, Emitter<NewTaskState> emit) {
    final title = Title.dirty(event.title);
    emit(state.copyWith(
      title: title,
      isValid: Formz.validate([title, state.content]),
    ));
  }

  void _onContentChanged(ContentChanged event, Emitter<NewTaskState> emit) {
    final content = Content.dirty(event.content);
    emit(state.copyWith(
      content: content,
      isValid: Formz.validate([state.title, content]),
    ));
  }

  void _onTaskTypeChanged(TypeChanged event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(type: event.type));
  }

  void _onUnitsChanged(UnitsChanged event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(units: event.units));
  }

  void _onImportantToggled(ImportantToggled event, Emitter<NewTaskState> emit) {
    emit(state.copyWith(important: !state.important));
  }

  void _onNewTaskSubmitted(NewTaskSubmitted event, Emitter<NewTaskState> emit) {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    }
  }
}
