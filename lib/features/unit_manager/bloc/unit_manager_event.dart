part of 'unit_manager_bloc.dart';

sealed class UnitManagerEvent extends Equatable {
  const UnitManagerEvent();

  @override
  List<Object> get props => [];
}

final class ChildUnitsFetchedEvent extends UnitManagerEvent {
  const ChildUnitsFetchedEvent({required this.parentUnitId});

  final String parentUnitId;

  @override
  List<Object> get props => [parentUnitId];
}
