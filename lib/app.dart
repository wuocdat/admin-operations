import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:target_repository/target_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/home/home.dart';
import 'package:tctt_mobile/login/login.dart';
import 'package:tctt_mobile/splash/splash.dart';
import 'package:tctt_mobile/theme/theme.dart';
import 'package:units_repository/units_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  late final UnitsRepository _unitsRepository;

  @override
  void initState() {
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    _unitsRepository = UnitsRepository();
    super.initState();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _unitsRepository),
        RepositoryProvider(create: (context) => TaskRepository()),
        RepositoryProvider(create: (context) => MailRepository()),
        RepositoryProvider(create: (context) => TargetRepository()),
      ],
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
