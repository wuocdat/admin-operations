import 'package:flutter/material.dart';
import 'package:tctt_mobile/dashboard/widget/mail_overview.dart';
import 'package:tctt_mobile/dashboard/widget/main_parameter.dart';
import 'package:tctt_mobile/dashboard/widget/task_overview.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          MainParameter(),
          TaskOverview(),
          MailOverview(),
        ],
      ),
    ));
  }
}
