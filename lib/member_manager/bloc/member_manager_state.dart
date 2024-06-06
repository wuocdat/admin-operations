part of 'member_manager_bloc.dart';

class MemberManagerState extends Equatable {
  const MemberManagerState({
    this.unitId,
    this.hasReachedMax = false,
    this.status = FetchDataStatus.initial,
    this.users = const <ShortProfile>[]
});
  
  final String? unitId;
  final bool hasReachedMax;
  final FetchDataStatus status;
  final List<ShortProfile> users;

  MemberManagerState copyWith({
    required String? unitId,
    required bool hasReachedMax,
    required FetchDataStatus status,
    required List<ShortProfile> users,
  }) {
    return MemberManagerState(
      unitId: unitId,
      hasReachedMax: hasReachedMax,
      status: status,
      users: users
    );
  }

  @override
  List<Object?> get props => [unitId, hasReachedMax, users];
}

