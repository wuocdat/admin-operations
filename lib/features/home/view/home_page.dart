import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/features/conversation/view/conversation_page.dart';
import 'package:tctt_mobile/features/dashboard/view/dashboard_page.dart';
import 'package:tctt_mobile/features/global/bloc/global_bloc.dart';
import 'package:tctt_mobile/features/home/cubit/home_cubit.dart';
import 'package:tctt_mobile/features/mail/view/mail_page.dart';
import 'package:tctt_mobile/features/received_task_detail/view/received_task_detail_page.dart';
import 'package:tctt_mobile/features/task/view/task_page.dart';
import 'package:tctt_mobile/features/setting/view/setting_page.dart';
import 'package:tctt_mobile/features/account_setting/view/account_setting_page.dart';
import 'package:tctt_mobile/shared/enums.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomePage(),
    );
  }

  static const List<Widget> _widgetOptions = [
    DashBoardPage(),
    TaskPage(),
    MailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final hasNavigatedOnLaunch =
        context.select((GlobalBloc bloc) => bloc.state.hasNavigatedOnLaunchApp);
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.account_box_outlined,
        'title': 'Quản lý tài khoản',
        'action': () {
          Navigator.of(context).push(AccountSetting.route());
        },
      },
      {
        'icon': Icons.settings_outlined,
        'title': 'Cài đặt',
        'action': () {
          Navigator.of(context).push(SettingPage.route());
        },
      },
      {
        'icon': Icons.logout_outlined,
        'title': 'Đăng xuất',
        'action': () {
          context
              .read<AuthenticationBloc>()
              .add(AuthenticationLogoutRequested());
        },
      },
    ];
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => HomeCubit(
        taskRepository: RepositoryProvider.of<TaskRepository>(context),
        mailRepository: RepositoryProvider.of<MailRepository>(context),
      )..checkIfAppLaunchedByNotification(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listenWhen: (previous, current) =>
            current.notificationData != null &&
            previous.notificationData != current.notificationData &&
            !hasNavigatedOnLaunch,
        listener: (context, state) {
          final notificationType =
              state.notificationData!.type.toENotificationType;

          final data = state.notificationData!.data;
          context.read<GlobalBloc>().add(const AppNavigatedOnLaunchEvent());

          switch (notificationType) {
            case ENotificationType.chat:
              Navigator.of(context).push(ConversationPage.route(data));
              break;
            case ENotificationType.mission:
              Navigator.of(context).push(ReceivedTaskDetailPage.route(data));
              break;
            default:
              break;
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                state.index.title,
                style: theme.textTheme.headlineMedium,
              ),
              actions: [
                // const Padding(
                //   padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                //   child: NotificationBell(count: 2),
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: state.index.isHome
                      ? MenuAnchor(
                          builder: (context, controller, child) => IconButton(
                                onPressed: () {
                                  if (controller.isOpen) {
                                    controller.close();
                                  } else {
                                    controller.open();
                                  }
                                },
                                icon: const Icon(Icons.account_circle_outlined),
                                iconSize: 30,
                              ),
                          menuChildren: menuItems
                              .map(
                                (e) => ListTile(
                                  leading: Icon(e['icon']),
                                  title: Text(e['title']),
                                  onTap: () {
                                    e['action']();
                                  },
                                ),
                              )
                              .toList())
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SettingPage()));
                          },
                          icon: const Icon(Icons.settings_outlined),
                          iconSize: 30,
                        ),
                ),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              // backgroundColor: Colors.white,
              onDestinationSelected: (int index) {
                context.read<HomeCubit>().changeIndex(index);
              },
              indicatorColor: theme.primaryColor,
              selectedIndex: state.index,
              destinations: <Widget>[
                const NavigationDestination(
                  selectedIcon: Icon(Icons.dashboard),
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Trang chủ',
                ),
                NavigationDestination(
                  selectedIcon: Badge(
                    label: Text('${state.unReadTaskNum}'),
                    isLabelVisible: state.unReadTaskNum > 0,
                    child: const Icon(Icons.task),
                  ),
                  icon: Badge(
                    label: Text('${state.unReadTaskNum}'),
                    isLabelVisible: state.unReadTaskNum > 0,
                    child: const Icon(Icons.task_outlined),
                  ),
                  label: 'Nhiệm vụ',
                ),
                NavigationDestination(
                  selectedIcon: Badge(
                    isLabelVisible: state.unReadMailNum > 0,
                    label: Text('${state.unReadMailNum}'),
                    child: const Icon(Icons.mail),
                  ),
                  icon: Badge(
                    isLabelVisible: state.unReadMailNum > 0,
                    label: Text('${state.unReadMailNum}'),
                    child: const Icon(Icons.mail_outline),
                  ),
                  label: 'Hòm thư',
                ),
              ],
            ),
            body: SafeArea(
              child: _widgetOptions.elementAt(state.index),
            ),
          );
        },
      ),
    );
  }
}

extension on int {
  String get title {
    switch (this) {
      case 0:
        return "Hệ thống MTTN";
      case 1:
        return "Nhiệm vụ";
    }
    return "Hòm thư";
  }

  bool get isHome => this == 0;
}
