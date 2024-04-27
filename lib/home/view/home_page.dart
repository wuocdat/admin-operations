import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, int>(
        builder: (context, selectedIndex) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                selectedIndex.title,
                style: theme.textTheme.headlineMedium,
              ),
              actions: [
                const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: NotificationBell(count: 2),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: selectedIndex.isHome
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
              selectedIndex: selectedIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.dashboard),
                  icon: Icon(Icons.dashboard_outlined),
                  label: 'Trang chủ',
                ),
                NavigationDestination(
                  selectedIcon: Badge(child: Icon(Icons.task)),
                  icon: Badge(child: Icon(Icons.task_outlined)),
                  label: 'Nhiệm vụ',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.supervised_user_circle),
                  icon: Icon(Icons.supervised_user_circle_outlined),
                  label: 'Đối tượng',
                ),
                NavigationDestination(
                  selectedIcon: Badge(
                    label: Text('2'),
                    child: Icon(Icons.mail),
                  ),
                  icon: Badge(
                    label: Text('2'),
                    child: Icon(Icons.mail_outline),
                  ),
                  label: 'Hòm thư',
                ),
                NavigationDestination(
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
              child: _widgetOptions.elementAt(selectedIndex),
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
    }
    return "Hòm thư";
  }

  bool get isHome => this == 0;
}
