import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:units_repository/units_repository.dart';

part 'unit_manager_event.dart';
part 'unit_manager_state.dart';

class UnitManagerBloc extends Bloc<UnitManagerEvent, UnitManagerState> {
  UnitManagerBloc({required UnitsRepository repository})
      : _unitmanagerRepository = repository,
        super(const UnitManagerState()) {
          on<UnitFetchedEvent>(
            _onUnitManagerFetched,
            transformer: throttleDroppable(throttleDuration),
          );
        }

  final UnitsRepository _unitmanagerRepository;

  Future<void> _onUnitManagerFetched(
    UnitFetchedEvent event,
    Emitter<UnitManagerState> emit,
  ) async {
    if (state.hasReachedMax) return;
    final units = await _unitmanagerRepository.getUnitsByParentId(
      event.parentId
    );

    emit(state.copyWith(
      hasReachedMax: true,
      status: FetchDataStatus.success,
      units: units,
      parentId: '',
    ));
  }
}
