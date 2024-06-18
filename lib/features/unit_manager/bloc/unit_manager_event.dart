part of 'unit_manager_bloc.dart';

sealed class UnitManagerEvent extends Equatable {
  const UnitManagerEvent();

  @override
  List<Object> get props => [];
}

class UnitFetchedEvent extends UnitManagerEvent {
  const UnitFetchedEvent(this.parentId);

  final String parentId;
  
  @override
  List<Object> get props => [];
}
