part of 'unit_manager_bloc.dart';

class UnitManagerState extends Equatable {
  const UnitManagerState({
    this.currentUnit = Unit.empty,
    this.childUnits = const [],
    this.status = FetchDataStatus.initial,
  });

  final Unit currentUnit;
  final List<Unit> childUnits;
  final FetchDataStatus status;

  UnitManagerState copyWith(
      {Unit? currentUnit, List<Unit>? childUnits, FetchDataStatus? status}) {
    return UnitManagerState(
      currentUnit: currentUnit ?? this.currentUnit,
      childUnits: childUnits ?? this.childUnits,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [currentUnit, childUnits, status];
}
