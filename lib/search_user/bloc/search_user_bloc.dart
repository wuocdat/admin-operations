import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:user_repository/user_repository.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc({required UserRepository userRepository})
      : _repository = userRepository,
        super(const SearchUserState()) {
    on<SearchInputChangeEvent>(
      _onSearchInputChange,
      transformer: debounce(debounceDuration),
    );
    on<ModeChangedEvent>(_onModeToggled);
    on<CheckBoxStatusChangeEvent>(_onCheckboxStatusChanged);
  }

  final UserRepository _repository;

  Future<void> _onSearchInputChange(
      SearchInputChangeEvent event, Emitter<SearchUserState> emit) async {
    if (event.value.isEmpty) {
      emit(state.copyWith(
        status: FetchDataStatus.success,
        users: List.empty(),
      ));

      return;
    }

    try {
      emit(state.copyWith(status: FetchDataStatus.loading));

      final users = await _repository.searchUsers(event.value);

      emit(state.copyWith(status: FetchDataStatus.success, users: users));
    } catch (_) {
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  void _onModeToggled(ModeChangedEvent event, Emitter<SearchUserState> emit) {
    emit(SearchUserState(groupMode: !state.groupMode));
  }

  void _onCheckboxStatusChanged(
      CheckBoxStatusChangeEvent event, Emitter<SearchUserState> emit) {
    if (!state.groupMode) return;

    if (event.checked) {
      emit(state.copyWith(
          pickedUsers: List.of(state.pickedUsers)..add(event.user)));
    } else {
      emit(
        state.copyWith(
            pickedUsers: List.of(state.pickedUsers)..remove(event.user)),
      );
    }
  }
}
