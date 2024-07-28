import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:user_repository/user_repository.dart';

part 'member_manager_event.dart';
part 'member_manager_state.dart';

class MemberManagerBloc extends Bloc<MemberManagerEvent, MemberManagerState> {
  MemberManagerBloc(
      {required UserRepository userRepository, required String unitId})
      : _userRepository = userRepository,
        _unitId = unitId,
        super(const MemberManagerState()) {
    on<UserFetchedEvent>(_onUserFetched);
    on<UserReFetchedEvent>(_onUserRefetched);
  }

  final UserRepository _userRepository;
  final String _unitId;

  Future<void> _onUserFetched(
    UserFetchedEvent event,
    Emitter<MemberManagerState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final users =
          await _userRepository.fetchUsersByUnitId(_unitId, state.users.length);

      users.length < userLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              users: List.of(state.users)..addAll(users),
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              users: List.of(state.users)..addAll(users),
            ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onUserRefetched(
    UserReFetchedEvent event,
    Emitter<MemberManagerState> emit,
  ) async {
    emit(const MemberManagerState(status: FetchDataStatus.loading));

    try {
      final users = await _userRepository.fetchUsersByUnitId(_unitId);

      users.length < userLimit
          ? emit(state.copyWith(
              hasReachedMax: true,
              status: FetchDataStatus.success,
              users: users,
            ))
          : emit(state.copyWith(
              status: FetchDataStatus.success,
              users: users,
            ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }
}
