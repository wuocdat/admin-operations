import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:user_repository/user_repository.dart';

part 'member_manager_event.dart';
part 'member_manager_state.dart';

class MemberManagerBloc extends Bloc<MemberManagerEvent, MemberManagerState> {
  MemberManagerBloc({required UserRepository repository})
      : _membermanagerRepository = repository,
        super(const MemberManagerState()) {
          on<MemberFetchedEvent>(
            _onMemberFetched,
            transformer:  throttleDroppable(throttleDuration),
          );
        }

  final UserRepository _membermanagerRepository;

  Future<void> _onMemberFetched(
    MemberFetchedEvent event,
    Emitter<MemberManagerState> emit,
  ) async {
    if (state.hasReachedMax) return;
    final members = await _membermanagerRepository.getUserbyUnitID(
      event.unitId,
      50,
      1
    );

    emit(state.copyWith(
      hasReachedMax: true,
      status: FetchDataStatus.success,
      allusers: members,
      unitId: '',
    ));
  }
}
