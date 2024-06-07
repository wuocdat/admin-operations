import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/features/target/cubit/target_cubit.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:units_repository/units_repository.dart';

part 'filter_content_state.dart';

class FilterContentCubit extends Cubit<FilterContentState> {
  FilterContentCubit({
    required UnitsRepository unitRepository,
    DateTime? startDate,
    DateTime? endDate,
    FbPageType? fbPageType,
    required Unit currentUnit,
    required List<Unit> stepUnitsList,
    required List<Unit> subUnitsList,
  })  : _unitsRepository = unitRepository,
        super(FilterContentState(
          pickedStartDate: startDate,
          pickedEndDate: endDate,
          fbPageType: fbPageType,
          currentUnit: currentUnit,
          stepUnitsList: stepUnitsList,
          subUnitsList: subUnitsList,
        ));

  final UnitsRepository _unitsRepository;

  Future<void> fetchUnits(Unit? currentUnit) async {
    if (currentUnit == null) return;

    emit(state.copyWith(
      status: FetchDataStatus.loading,
      stepUnitsList: List.from(state.stepUnitsList)..add(currentUnit),
      currentUnit: currentUnit,
    ));

    try {
      final subUnits =
          await _unitsRepository.getUnitsByParentId(currentUnit.id);

      emit(state.copyWith(
          status: FetchDataStatus.success, subUnitsList: subUnits));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  void updateStartDate(DateTime date) {
    emit(state.copyWith(pickedStartDate: date));
  }

  void updateEndDate(DateTime date) {
    emit(state.copyWith(pickedEndDate: date));
  }

  void updateFbPageType(FbPageType? type) {
    emit(state.copyWith(fbPageType: type, unsetFbPageType: type == null));
  }

  Future<void> resetStateFilter(Unit rootUnit) async {
    emit(state.copyWith(
      fbPageType: null,
      unsetFbPageType: true,
      pickedStartDate: DateTime.now().subtract(const Duration(days: 1)),
      pickedEndDate: DateTime.now(),
      stepUnitsList: [],
      subUnitsList: [],
      currentUnit: rootUnit,
    ));

    await fetchUnits(rootUnit);
  }
}
