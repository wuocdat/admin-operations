part of 'member_manager_bloc.dart';

class MemberManagerState extends Equatable {
  const MemberManagerState({
    this.unitId,
    this.hasReachedMax = false,
    this.status = FetchDataStatus.initial,
    this.allusers = const <User>[]
});
  
  final String? unitId;
  final bool hasReachedMax;
  final FetchDataStatus status;
  final List<User> allusers;

  MemberManagerState copyWith({
    required String? unitId,
    required bool hasReachedMax,
    required FetchDataStatus status,
    required List<User> allusers,
  }) {
    return MemberManagerState(
      unitId: unitId,
      hasReachedMax: hasReachedMax,
      status: status,
      allusers: allusers
    );
  }

  @override
  List<Object?> get props => [unitId, hasReachedMax, allusers];
}

