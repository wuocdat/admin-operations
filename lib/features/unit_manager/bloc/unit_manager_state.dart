part of 'unit_manager_bloc.dart';

class UnitManagerState extends Equatable {
  const UnitManagerState({
    this.parentId,
    this.hasReachedMax = false,
    this.status = FetchDataStatus.initial,
    this.units = const <Unit>[]
  });
  
  final String? parentId;
  final bool hasReachedMax;
  final FetchDataStatus status;
  final List<Unit> units;

  UnitManagerState copyWith({
    required String? parentId,
    required bool hasReachedMax,
    required FetchDataStatus status,
    required List<Unit> units,
  }) {
    return UnitManagerState(
      parentId: parentId,
      hasReachedMax: hasReachedMax,
      status: status,
      units: units,
    );
  }

  @override
  List<Object?> get props => [parentId, hasReachedMax, units];
}
