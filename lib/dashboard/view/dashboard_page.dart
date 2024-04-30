import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mail_repository/mail_repository.dart';
import 'package:target_repository/target_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/dashboard/widget/mail_overview.dart';
import 'package:tctt_mobile/dashboard/widget/main_parameter.dart';
import 'package:tctt_mobile/dashboard/widget/target_overview.dart';
import 'package:tctt_mobile/dashboard/widget/task_overview.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(
        taskRepository: RepositoryProvider.of<TaskRepository>(context),
        mailRepository: RepositoryProvider.of<MailRepository>(context),
        targetRepository: RepositoryProvider.of<TargetRepository>(context),
      )
        ..add(const TaskOverallSubscriptionRequested())
        ..add(const MailOverallSubscriptionRequested()),
      child: const Scaffold(
          body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            MainParameter(),
            TaskOverview(),
            MailOverview(),
            TargetOverview(),
            SizedBox(height: 16),
          ],
        ),
      )),
    );
  }
}
