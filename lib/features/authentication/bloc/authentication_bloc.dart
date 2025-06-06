import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tctt_mobile/core/services/firebase_service.dart';
import 'package:user_repository/user_repository.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.g.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status
        .listen((status) => add(_AuthenticationStatusChanged(status)));
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user != null
            ? AuthenticationState.authenticated(user)
            : const AuthenticationState.unknown());
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      //cancelling all notifications
      await flutterLocalNotificationsPlugin.cancelAll();

      final fcmToken = await getFCMToken();
      await _authenticationRepository.logout(fcmToken ?? "");
    } catch (_) {
      emit(const AuthenticationState.unauthenticated());
    }
  }

  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      return null;
    }
  }

  @override
  AuthenticationState fromJson(Map<String, dynamic> json) =>
      AuthenticationState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) => state.toJson();
}
