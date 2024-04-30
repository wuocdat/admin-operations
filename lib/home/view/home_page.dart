import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/conversation_center/view/conversation_center_page.dart';
import 'package:tctt_mobile/dashboard/view/dashboard_page.dart';
import 'package:tctt_mobile/home/cubit/home_cubit.dart';
import 'package:tctt_mobile/home/widgets/notifications_bell.dart';
import 'package:tctt_mobile/mail/view/mail_page.dart';
import 'package:tctt_mobile/target/view/target_page.dart';
import 'package:tctt_mobile/task/view/task_page.dart';

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
    TargetPage(),
    MailPage(),
    ConversationCenter(),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': Icons.account_box_outlined,
        'title': 'Quản lý tài khoản',
        'action': () {
          //Navigator.of(context).push();
        },
      },
      {
        'icon': Icons.settings_outlined,
        'title': 'Cài đặt',
        'action': () {
          //Navigator.of(context).push();
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
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                state.index.title,
                style: theme.textTheme.headlineMedium,
              ),
              actions: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: NotificationBell(count: 2),
                ),
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
                            // navigate to settings page
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
                const NavigationDestination(
                  selectedIcon: Icon(Icons.supervised_user_circle),
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'Đối tượng',
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
                const NavigationDestination(
                  selectedIcon: Badge(
                    label: Text('5'),
                    child: Icon(Icons.messenger),
                  ),
                  icon: Badge(
                    label: Text('5'),
                    child: Icon(Icons.messenger_outline),
                  ),
                  label: 'Nhắn tin',
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
      case 2:
        return "Đối tượng";
      case 3:
        return "Hòm thư";
    }
    return "Nhắn tin";
  }

  bool get isHome => this == 0;
}
