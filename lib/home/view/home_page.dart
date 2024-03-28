import 'package:flutter/material.dart';
import 'package:tctt_mobile/dashboard/view/dashboard_page.dart';
import 'package:tctt_mobile/mail/view/mail_page.dart';
import 'package:tctt_mobile/target/view/target_page.dart';
import 'package:tctt_mobile/task/view/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  static const List<Widget> _widgetOptions = [
    DashBoardPage(),
    TaskPage(),
    TargetPage(),
    MailPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Hệ thống MTTN",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.account_circle_outlined),
              iconSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        // backgroundColor: Colors.white,
        onDestinationSelected: _onItemTapped,
        indicatorColor: Theme.of(context).primaryColor,
        selectedIndex: currentPageIndex,
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
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
    );
  }
}
