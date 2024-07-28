import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/models/content.dart';
import 'package:units_repository/units_repository.dart';

part 'unit_manager_event.dart';
part 'unit_manager_state.dart';

class UnitManagerBloc extends Bloc<UnitManagerEvent, UnitManagerState> {
  UnitManagerBloc({required UnitsRepository unitsRepository})
      : _unitsRepository = unitsRepository,
        super(const UnitManagerState()) {
    on<ChildUnitsFetchedEvent>(_onChildUnitsFetched);
    on<UnitNameChangedEvent>(_onUnitNameChanged);
    on<UnitTypeIdChangedEvent>(_onUnitTypeIdChanged);
    on<FormClearedEvent>(_onFormCleared);
    on<NewUnitCreatedEvent>(_onNewUnitCreated);
    on<UnitDeletedEvent>(_onUnitDeleted);
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
      final childUnitTypes =
          await _unitsRepository.getChildrenUnitTypes(event.parentUnitTypeId);

      emit(state.copyWith(
          status: FetchDataStatus.success,
          currentUnit: currentUnit,
          childUnits: childUnits,
          childUnitTypes: childUnitTypes));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  void _onUnitNameChanged(
      UnitNameChangedEvent event, Emitter<UnitManagerState> emit) {
    final name = Content.dirty(event.name);
    emit(state.copyWith(
      unitName: name,
      isValid: Formz.validate([name]) && state.unitTypeId != null,
    ));
  }

  void _onUnitTypeIdChanged(
      UnitTypeIdChangedEvent event, Emitter<UnitManagerState> emit) {
    emit(state.copyWith(
      unitTypeId: event.unitTypeId,
      isValid: Formz.validate([state.unitName]),
    ));
  }

  void _onFormCleared(FormClearedEvent event, Emitter<UnitManagerState> emit) {
    emit(state.copyWithAndClearForm());
  }

  Future<void> _onNewUnitCreated(
      NewUnitCreatedEvent event, Emitter<UnitManagerState> emit) async {
    emit(state.copyWith(formStatus: FormzSubmissionStatus.inProgress));

    try {
      await _unitsRepository.createUnit(
          event.name, event.parentUnitId, event.type);
      emit(state.copyWithAndClearForm());
      emit(state.copyWith(formStatus: FormzSubmissionStatus.success));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(formStatus: FormzSubmissionStatus.failure));
    }
  }

  Future<void> _onUnitDeleted(
      UnitDeletedEvent event, Emitter<UnitManagerState> emit) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      await _unitsRepository.deleteUnitById(event.unitId);
      final childUnits =
          await _unitsRepository.getUnitsByParentId(state.currentUnit.id);
      emit(state.copyWith(
        status: FetchDataStatus.success,
        childUnits: childUnits,
      ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
