import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  TargetCubit() : super(const TargetState.subject());

  void changeOption(TargetOptions option) {
    emit(state.copyWith(selectedOption: option));
  }
}
