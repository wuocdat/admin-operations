import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:units_repository/units_repository.dart';

part 'unit_manager_event.dart';
part 'unit_manager_state.dart';

class UnitManagerBloc extends Bloc<UnitManagerEvent, UnitManagerState> {
  UnitManagerBloc({required UnitsRepository unitsRepository})
      : _unitsRepository = unitsRepository,
        super(const UnitManagerState()) {
    on<ChildUnitsFetchedEvent>(_onChildUnitsFetched);
  }

  final UnitsRepository _unitsRepository;

  Future<void> _onChildUnitsFetched(
      ChildUnitsFetchedEvent event, Emitter<UnitManagerState> emit) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final currentUnit =
          await _unitsRepository.getUnitById(event.parentUnitId);
      final childUnits =
          await _unitsRepository.getUnitsByParentId(event.parentUnitId);

      emit(state.copyWith(
        status: FetchDataStatus.success,
        currentUnit: currentUnit,
        childUnits: childUnits,
      ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
