part of 'new_unit_bloc.dart';

sealed class NewUnitState extends Equatable {
  const NewUnitState();
  
  @override
  List<Object> get props => [];
}

final class NewUnitInitial extends NewUnitState {}
