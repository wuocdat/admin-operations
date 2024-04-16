import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/sent_task_detail/cubit/sent_task_detail_cubit.dart';
import 'package:tctt_mobile/sent_task_detail/widgets/attachment.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/widgets/content_container.dart';

class SentTaskDetailPage extends StatelessWidget {
  const SentTaskDetailPage({super.key, required this.taskId});

  static Route<bool> route(String taskId) {
    return MaterialPageRoute<bool>(
      builder: (_) => BlocProvider(
        create: (context) => SentTaskDetailCubit(context.read<TaskRepository>())
          ..fetchTask(taskId),
        child: SentTaskDetailPage(taskId: taskId),
      ),
    );
  }

  final String taskId;

  Future<void> _showWithDrawDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(
          value: BlocProvider.of<SentTaskDetailCubit>(context),
          child: BlocBuilder<SentTaskDetailCubit, SentTaskDetailState>(
            builder: (context, state) {
              return AlertDialog(
                title: const Text('Thu hồi nhiệm vụ'),
                content: const SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('Bạn có chắc chắn muốn thu hồi nhiệm vụ này không?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  if (!state.status.isLoading)
                    TextButton(
                      child: const Text('Thoát'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  if (!state.status.isLoading)
                    ElevatedButton(
                      onPressed: () => context
                          .read<SentTaskDetailCubit>()
                          .withDrawTask(taskId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Thu hồi'),
                    ),
                  if (state.status.isLoading) const CircularProgressIndicator(),
                ],
              );
            },
          ),
        );
      },
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
                  if (state.currentTask.disable && state.status.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Thu hồi nhiệm vụ thành công'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Exit dialog
                    Navigator.pop(context);

                    // Go back and return true to refresh task list
                    Navigator.of(context).pop(true);
                  }
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
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.star,
                              color: Theme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          IconButton(
                            onPressed: () => _showWithDrawDialog(context),
                            icon: Icon(
                              Icons.delete_outlined,
                              color: Theme.of(context).colorScheme.error,
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                      if (state.currentTask.files.isNotEmpty) const Divider(),
                      Attachment(filePaths: state.currentTask.files),
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
