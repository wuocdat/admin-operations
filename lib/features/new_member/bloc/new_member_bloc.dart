import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:tctt_mobile/shared/models/password.dart';
import 'package:user_repository/user_repository.dart';

part 'new_member_event.dart';
part 'new_member_state.dart';

class NewMemberBloc extends Bloc<NewMemberEvent, NewMemberState> {
  NewMemberBloc(
      {required UserRepository userRepository, required String unitId})
      : _userRepository = userRepository,
        _unitId = unitId,
        super(const NewMemberState()) {
    on<MemberNameChangedEvent>(_onMemberNameChanged);
    on<MemberUserNameChangedEvent>(_onMemberUsernameChanged);
    on<MemberPasswordChangedEvent>(_onMemberPasswordChanged);
    on<MemberRepeatPassChangedEvent>(_onMemberRepeatPassChanged);
    on<MemberRoleChangedEvent>(_onMemberRoleChanged);
    on<NewMemberSubmittedEvent>(_onNewMemberSubmitted);
  }

  final UserRepository _userRepository;
  final String _unitId;

  void _onMemberNameChanged(
      MemberNameChangedEvent event, Emitter<NewMemberState> emit) {
    final name = Content.dirty(event.text);

    emit(state.copyWith(
        name: name,
        isValid: Formz.validate(
                [name, state.username, state.password, state.repeatPass]) &&
            state.confirmPass));
  }

  void _onMemberUsernameChanged(
      MemberUserNameChangedEvent event, Emitter<NewMemberState> emit) {
    final username = Content.dirty(event.text);

    emit(state.copyWith(
        username: username,
        isValid: Formz.validate(
                [username, state.name, state.password, state.repeatPass]) &&
            state.confirmPass));
  }

  void _onMemberPasswordChanged(
      MemberPasswordChangedEvent event, Emitter<NewMemberState> emit) {
    final pass = Password.dirty(event.text);

    emit(state.copyWith(
        password: pass,
        isValid: Formz.validate(
                [pass, state.username, state.name, state.repeatPass]) &&
            event.text == state.repeatPass.value));
  }

  void _onMemberRepeatPassChanged(
      MemberRepeatPassChangedEvent event, Emitter<NewMemberState> emit) {
    final repeatPass = Password.dirty(event.text);

    emit(state.copyWith(
        repeatPass: repeatPass,
        isValid: Formz.validate(
                [repeatPass, state.username, state.password, state.name]) &&
            state.password.value == event.text));
  }

  void _onMemberRoleChanged(
      MemberRoleChangedEvent event, Emitter<NewMemberState> emit) {
    emit(state.copyWith(role: event.role));
  }

  Future<void> _onNewMemberSubmitted(
      NewMemberSubmittedEvent event, Emitter<NewMemberState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

    try {
      if (state.isValid) {
        await _userRepository.createUser(state.name.value, state.username.value,
            _unitId, state.password.value, state.role.id);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
