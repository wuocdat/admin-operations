import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/sent_task_detail/cubit/sent_task_detail_cubit.dart';
import 'package:tctt_mobile/widgets/content_container.dart';

class SentTaskDetailPage extends StatelessWidget {
  const SentTaskDetailPage({super.key, required this.taskId});

  static Route<void> route(String taskId) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider(
        create: (context) => SentTaskDetailCubit(context.read<TaskRepository>())
          ..fetchTask(taskId),
        child: SentTaskDetailPage(taskId: taskId),
      ),
    );
  }

  final String taskId;

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
            'Nhiệm vụ',
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
                child: BlocConsumer<SentTaskDetailCubit, SentTaskDetailState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        ContentContainer(
                          title: state.currentTask.name,
                          content: state.currentTask.content,
                          time: state.currentTask.createdAt,
                          actions: [
                            Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8, 0, 0, 0),
                              child: Icon(
                                Icons.delete_outlined,
                                color: Theme.of(context).colorScheme.error,
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
