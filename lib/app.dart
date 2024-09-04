import 'package:authentication_repository/authentication_repository.dart';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:target_repository/target_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/core/services/firebase_service.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/global/bloc/global_bloc.dart';
import 'package:tctt_mobile/features/home/home.dart';
import 'package:tctt_mobile/features/login/login.dart';
import 'package:tctt_mobile/features/splash/splash.dart';
import 'package:tctt_mobile/core/theme/theme.dart';
import 'package:tctt_mobile/shared/enums.dart';
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
  late final ConversationRepository _conversationRepository;

  @override
  void initState() {
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
    _unitsRepository = UnitsRepository();
    _conversationRepository = ConversationRepository();
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
        RepositoryProvider.value(value: _conversationRepository),
        RepositoryProvider(create: (context) => TaskRepository()),
        RepositoryProvider(create: (context) => MailRepository()),
        RepositoryProvider(create: (context) => TargetRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: _authenticationRepository,
              userRepository: _userRepository,
            ),
          ),
          BlocProvider(
            create: (context) =>
                GlobalBloc(conversationRepository: _conversationRepository),
          ),
        ],
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

  void _pushNotificationToStream(RemoteMessage message) {
    final messType = message.data['type'];
    if (messType == null) return;
    final typeValue = messType as String;
    switch (typeValue.toENotificationType) {
      case ENotificationType.mission:
        // Handle task
        break;

      case ENotificationType.mail:
        // Handle mail
        break;

      case ENotificationType.chat:
        final conversationId = message.data['conversationId'];
        context
            .read<GlobalBloc>()
            .add(ConversationDataPushedEvent(conversationId));
        break;
    }
  }

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _pushNotificationToStream(message);
      showFlutterNotification(message);
    });
  }

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
