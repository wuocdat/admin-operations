import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/features/target/models/filter_data.dart';

part 'target_state.dart';

class TargetCubit extends Cubit<TargetState> {
  TargetCubit() : super(const TargetState.subject());

  void changeOption(TargetOptions option) {
    emit(state.copyWith(selectedOption: option));
  }

  void changeViewIndex(int index) {
    emit(state.copyWith(viewIndex: index));
  }

  void resetTime() {
    emit(
      state.copyWith(
          startDate: DateTime.now().subtract(const Duration(days: 1)),
          endDate: DateTime.now()),
    );
  }

  void updateFilterDataForActionView(FilterData data) {
    emit(state.copyWith(
      endDate: data.endDate,
      startDate: data.startDate,
      updateFilterCount: state.updateFilterCount + 1,
    ));
  }
}
