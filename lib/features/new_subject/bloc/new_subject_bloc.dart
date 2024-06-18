import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:target_repository/target_repository.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';

part 'new_subject_event.dart';
part 'new_subject_state.dart';

class NewSubjectBloc extends Bloc<NewSubjectEvent, NewSubjectState> {
  NewSubjectBloc(
      {required TargetRepository targetRepository, required int typeAc})
      : _targetRepository = targetRepository,
        _typeAc = typeAc,
        super(const NewSubjectState()) {
    on<NameChangedEvent>(_onNameChanged);
    on<UidChangedEvent>(_onUidChanged);
    on<FbPageTypeChangedEvent>(_onFbPageTypeChanged);
    on<NewSubjectSubmitted>(_onNewSubjectSubmitted);
  }

  final TargetRepository _targetRepository;
  final int _typeAc;

  void _onNameChanged(
    NameChangedEvent event,
    Emitter<NewSubjectState> emit,
  ) {
    final name = Content.dirty(event.text);
    emit(state.copyWith(
      name: name,
      isValid: Formz.validate([name, state.uid]),
    ));
  }

  void _onUidChanged(
    UidChangedEvent event,
    Emitter<NewSubjectState> emit,
  ) {
    final uid = Content.dirty(event.text);
    emit(state.copyWith(
      uid: uid,
      isValid: Formz.validate([uid, state.name]),
    ));
  }

  void _onFbPageTypeChanged(
    FbPageTypeChangedEvent event,
    Emitter<NewSubjectState> emit,
  ) {
    emit(state.copyWith(fbPageType: event.type));
  }

  Future<void> _onNewSubjectSubmitted(
      NewSubjectSubmitted event, Emitter<NewSubjectState> emit) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      try {
        await _targetRepository.createSubject(state.name.value,
            state.fbPageType.strId, "$_typeAc", state.uid.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
