import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/services/socket_service.dart';
import 'package:tctt_mobile/shared/debounce.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:user_repository/user_repository.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc({required UserRepository userRepository})
      : _repository = userRepository,
        _socketIOService = CreatingConversationSocketIOService(),
        super(const SearchUserState()) {
    on<SearchInputChangeEvent>(
      _onSearchInputChange,
      transformer: debounce(debounceDuration),
    );
    on<ModeChangedEvent>(_onModeToggled);
    on<CheckBoxStatusChangeEvent>(_onCheckboxStatusChanged);
    on<OneByOneConversationCreatedEvent>(_onOneByOneConversationCreated);
    on<_ConversationIdReceivedEvent>(_onConversationIdReceived);
    on<UserFetchedEvent>(
      _onUserFetched,
      transformer: throttleDroppable(throttleDuration),
    );

    _socketIOService.connect();

    _conversationIdSubscription = _socketIOService.getResponse
        .listen((id) => add(_ConversationIdReceivedEvent(id)));
  }

  final UserRepository _repository;
  final CreatingConversationSocketIOService _socketIOService;
  late StreamSubscription<String> _conversationIdSubscription;

  @override
  Future<void> close() {
    _conversationIdSubscription.cancel();
    _socketIOService.dispose();
    return super.close();
  }

  Future<void> _onSearchInputChange(
      SearchInputChangeEvent event, Emitter<SearchUserState> emit) async {
    if (event.value.isEmpty) {
      emit(state.copyWith(
        searchValue: "",
        status: FetchDataStatus.success,
        users: List.empty(),
        hasReachedMax: true,
      ));

      return;
    }

    try {
      emit(state.copyWith(
        status: FetchDataStatus.loading,
        searchValue: event.value,
        users: List<ShortProfile>.empty(),
        hasReachedMax: true,
      ));

      final users = await _repository.searchUsers(event.value);

      emit(state.copyWith(
          status: FetchDataStatus.success,
          users: users,
          hasReachedMax: users.length < userLimit));
    } catch (_) {
      emit(state.copyWith(
          status: FetchDataStatus.failure, users: List<ShortProfile>.empty()));
    }
  }

  Future<void> _onUserFetched(
    UserFetchedEvent event,
    Emitter<SearchUserState> emit,
  ) async {
    if (state.hasReachedMax) return;

    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final users = await _repository.searchUsers(state.searchValue);

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

  void _onOneByOneConversationCreated(
    OneByOneConversationCreatedEvent event,
    Emitter<SearchUserState> emit,
  ) {
    emit(state.copyWith(creatingStatus: CreateConversationStatus.loading));

    _socketIOService.sendOneByOneConversationRequest(event.otherUserId);
  }

  void _onConversationIdReceived(
    _ConversationIdReceivedEvent event,
    Emitter<SearchUserState> emit,
  ) {
    emit(state.copyWith(
      creatingStatus: CreateConversationStatus.success,
      conversationId: event.conversationId,
    ));
  }
}
