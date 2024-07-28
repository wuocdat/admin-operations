part of 'unit_manager_bloc.dart';

sealed class UnitManagerEvent extends Equatable {
  const UnitManagerEvent();

  @override
  List<Object> get props => [];
}

final class ChildUnitsFetchedEvent extends UnitManagerEvent {
  const ChildUnitsFetchedEvent({
    required this.parentUnitId,
    required this.parentUnitTypeId,
  });

  final String parentUnitId;
  final String parentUnitTypeId;

  @override
  List<Object> get props => [parentUnitId, parentUnitTypeId];
}

final class UnitNameChangedEvent extends UnitManagerEvent {
  const UnitNameChangedEvent(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

final class UnitTypeIdChangedEvent extends UnitManagerEvent {
  const UnitTypeIdChangedEvent(this.unitTypeId);

  final String unitTypeId;

  @override
  List<Object> get props => [unitTypeId];
}

final class FormClearedEvent extends UnitManagerEvent {
  const FormClearedEvent();

  @override
  List<Object> get props => [];
}

final class NewUnitCreatedEvent extends UnitManagerEvent {
  const NewUnitCreatedEvent(this.name, this.parentUnitId, this.type);

  final String name;
  final String parentUnitId;
  final String type;

  @override
  List<Object> get props => [name, parentUnitId, type];
}

final class UnitDeletedEvent extends UnitManagerEvent {
  const UnitDeletedEvent(this.unitId);

  final String unitId;

  @override
  List<Object> get props => [unitId];
}
