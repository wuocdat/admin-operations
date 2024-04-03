import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/authentication/bloc/authentication_bloc.dart';
import 'package:tctt_mobile/dashboard/view/dashboard_page.dart';
import 'package:tctt_mobile/home/cubit/home_cubit.dart';
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
    MailPage()
  ];

  @override
  Widget build(BuildContext context) {
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
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  child: IconButton(
                    onPressed: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationLogoutRequested());
                    },
                    icon: selectedIndex.isHome
                        ? const Icon(Icons.account_circle_outlined)
                        : const Icon(Icons.settings_outlined),
                    iconSize: 30,
                    // color: theme.primaryColor,
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
