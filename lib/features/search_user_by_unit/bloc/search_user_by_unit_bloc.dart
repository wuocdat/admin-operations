import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tctt_mobile/core/services/socket_service.dart';
import 'package:tctt_mobile/core/utils/logger.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:units_repository/units_repository.dart';
import 'package:user_repository/user_repository.dart';

part 'search_user_by_unit_event.dart';

part 'search_user_by_unit_state.dart';

class SearchUserByUnitBloc
    extends Bloc<SearchUserByUnitEvent, SearchUserByUnitState> {
  SearchUserByUnitBloc(
      {required UserRepository userRepository,
      required UnitsRepository unitsRepository})
      : _userRepository = userRepository,
        _unitsRepository = unitsRepository,
        _socketIOService = CreatingConversationSocketIOService(),
        super(const SearchUserByUnitState()) {
    on<RootUserFetchedEvent>(_onRootUserFetched);
    on<UnitSelectedEvent>(_onUnitSelected);
    on<OneByOneConversationCreatedEvent>(_onOneByOneConversationCreated);
    on<_ConversationIdReceivedEvent>(_onConversationIdReceived);

    _socketIOService.connect();

    _conversationIdSubscription = _socketIOService.getResponse
        .listen((id) => add(_ConversationIdReceivedEvent(id)));
  }

  final UserRepository _userRepository;
  final UnitsRepository _unitsRepository;
  final CreatingConversationSocketIOService _socketIOService;
  late StreamSubscription<String> _conversationIdSubscription;

  @override
  Future<void> close() {
    _conversationIdSubscription.cancel();
    _socketIOService.dispose();
    return super.close();
  }

  Future<void> _onRootUserFetched(
      RootUserFetchedEvent event, Emitter<SearchUserByUnitState> emit) async {
    emit(state.copyWith(status: FetchDataStatus.loading));

    try {
      final nodeList = await _unitsRepository.getFullUnitTree();
      final rootUnit = nodeList[0];

      emit(state.copyWith(
        status: FetchDataStatus.success,
        currentUnit: rootUnit,
        subUnitsList: rootUnit.children,
        stepUnitsList: [rootUnit],
      ));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure));
    }
  }

  Future<void> _onUnitSelected(
      UnitSelectedEvent event, Emitter<SearchUserByUnitState> emit) async {
    emit(state.copyWith(
      stepUnitsList: List.from(state.stepUnitsList)..add(event.selectedUnit),
      subUnitsList: event.selectedUnit.children ?? [],
      currentUnit: event.selectedUnit,
      status: FetchDataStatus.loading,
    ));
    try {
      final users =
          await _userRepository.getChatUsersByUnitId(event.selectedUnit.value);
      emit(state.copyWith(status: FetchDataStatus.success, users: users));
    } catch (e) {
      logger.severe(e);
      emit(state.copyWith(status: FetchDataStatus.failure, users: const []));
    }
  }

  void _onOneByOneConversationCreated(
      OneByOneConversationCreatedEvent event,
      Emitter<SearchUserByUnitState> emit,
      ) {
    emit(state.copyWith(creatingStatus: FetchDataStatus.loading));

    _socketIOService.sendOneByOneConversationRequest(event.otherUserId);
  }

  void _onConversationIdReceived(
      _ConversationIdReceivedEvent event,
      Emitter<SearchUserByUnitState> emit,
      ) {
    emit(state.copyWith(
      creatingStatus: FetchDataStatus.success,
      conversationId: event.conversationId,
    ));
  }
}
