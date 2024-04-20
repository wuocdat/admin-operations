import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/received_task_detail/cubit/received_task_detail_cubit.dart';
import 'package:tctt_mobile/received_task_detail/widgets/report_detail.dart';
import 'package:tctt_mobile/received_task_detail/widgets/report_form.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/widgets/attachment/attachment.dart';
import 'package:tctt_mobile/widgets/content_container.dart';

class ReceivedTaskDetailPage extends StatelessWidget {
  const ReceivedTaskDetailPage({super.key});

  static Route<bool> route(String taskId) {
    return MaterialPageRoute<bool>(
      builder: (_) => BlocProvider(
        create: (context) =>
            ReceivedTaskDetailCubit(context.read<TaskRepository>())
              ..fetchTask(taskId),
        child: const ReceivedTaskDetailPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Nhận nhiệm vụ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: BlocConsumer<ReceivedTaskDetailCubit,
                  ReceivedTaskDetailState>(
                listener: (context, state) {
                  if (state.status.isFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Có lỗi xảy ra'),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    children: [
                      ContentContainer(
                        sender: state.currentTask.unitSent.name,
                        title: state.currentTask.name,
                        content: state.currentTask.content,
                        time: state.currentTask.createdAt,
                        actions: [
                          if (state.currentTask.important)
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.star,
                                color: Theme.of(context).primaryColor,
                                size: 24,
                              ),
                            ),
                        ],
                      ),
                      if (state.currentTask.files.isNotEmpty) const Divider(),
                      if (state.currentTask.files.isNotEmpty)
                        Attachment(filePaths: state.currentTask.files),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(),
                      ),
                      if (state.reportStatus.isDetailMode)
                        BlocSelector<ReceivedTaskDetailCubit,
                                ReceivedTaskDetailState, Progress>(
                            selector: (state) =>
                                state.currentTask.progress ?? Progress.empty,
                            builder: (context, progress) {
                              return ReportDetail(
                                progress: progress,
                                onReportAgain: () {
                                  context
                                      .read<ReceivedTaskDetailCubit>()
                                      .reportAgain();
                                },
                              );
                            }),
                      if (state.reportStatus.isFormMode)
                        ReportForm(
                          onClosed:
                              ((state.currentTask.progress?.repeat ?? 0) > 0)
                                  ? () {
                                      context
                                          .read<ReceivedTaskDetailCubit>()
                                          .closeFormMode();
                                    }
                                  : null,
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension on ReportStatus {
  bool get isDetailMode => this == ReportStatus.detail;
  bool get isFormMode => this == ReportStatus.form;
}
