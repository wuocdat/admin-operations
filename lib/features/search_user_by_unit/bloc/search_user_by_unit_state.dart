part of 'search_user_by_unit_bloc.dart';

class SearchUserByUnitState extends Equatable {
  const SearchUserByUnitState({
    this.users = const [],
    this.status = FetchDataStatus.initial,
    this.currentUnit = UnitNode.empty,
    this.stepUnitsList = const [],
    this.subUnitsList = const [],
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final UnitNode currentUnit;
  final List<UnitNode> stepUnitsList;
  final List<UnitNode> subUnitsList;

  SearchUserByUnitState copyWith({
    List<ShortProfile>? users,
    FetchDataStatus? status,
    UnitNode? currentUnit,
    List<UnitNode>? stepUnitsList,
    List<UnitNode>? subUnitsList,
  }) {
    return SearchUserByUnitState(
      users: users ?? this.users,
      status: status ?? this.status,
      currentUnit: currentUnit ?? this.currentUnit,
      stepUnitsList: stepUnitsList ?? this.stepUnitsList,
      subUnitsList: subUnitsList ?? this.subUnitsList,
    );
  }

  @override
  List<Object> get props =>
      [users, status, currentUnit, stepUnitsList, subUnitsList];
}
