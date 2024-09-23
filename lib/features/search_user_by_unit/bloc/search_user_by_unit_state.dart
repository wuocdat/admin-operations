part of 'search_user_by_unit_bloc.dart';

class SearchUserByUnitState extends Equatable {
  const SearchUserByUnitState({
    this.users = const [],
    this.status = FetchDataStatus.initial,
    this.creatingStatus = FetchDataStatus.initial,
    this.currentUnit = UnitNode.empty,
    this.stepUnitsList = const [],
    this.subUnitsList = const [],
    this.conversationId,
  });

  final List<ShortProfile> users;
  final FetchDataStatus status;
  final FetchDataStatus creatingStatus;
  final UnitNode currentUnit;
  final List<UnitNode> stepUnitsList;
  final List<UnitNode> subUnitsList;
  final String? conversationId;

  SearchUserByUnitState copyWith({
    List<ShortProfile>? users,
    FetchDataStatus? status,
    FetchDataStatus? creatingStatus,
    UnitNode? currentUnit,
    List<UnitNode>? stepUnitsList,
    List<UnitNode>? subUnitsList,
    String? conversationId,
  }) {
    return SearchUserByUnitState(
      users: users ?? this.users,
      status: status ?? this.status,
      creatingStatus: creatingStatus ?? this.creatingStatus,
      currentUnit: currentUnit ?? this.currentUnit,
      stepUnitsList: stepUnitsList ?? this.stepUnitsList,
      subUnitsList: subUnitsList ?? this.subUnitsList,
      conversationId: conversationId ?? this.conversationId,
    );
  }

  @override
  List<Object?> get props => [
        users,
        status,
        creatingStatus,
        currentUnit,
        stepUnitsList,
        subUnitsList,
        conversationId,
      ];
}
