import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/task/widgets/received_task/bloc/receiver_bloc.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/msg_item.dart';

class ReceivedTasks extends StatelessWidget {
  const ReceivedTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiverBloc(
          repository: RepositoryProvider.of<TaskRepository>(context))
        ..add(const ReceiverStartedEvent()),
      child: BlocListener<ReceiverBloc, ReceiverState>(
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text("Đã xảy ra lỗi")),
              );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text("options"),
            Expanded(
              child: BlocBuilder<ReceiverBloc, ReceiverState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ReceiverStatus.loading:
                      return const Loader();
                    default:
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final task = state.tasks[index];
                          return index > state.tasks.length
                              ? const CircularProgressIndicator()
                              : MessageItem(
                                  time: task.createdAt,
                                  title: task.unitSent.name,
                                  content: task.content,
                                );
                        },
                        itemCount: state.tasks.length,
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 12,
                        ),
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

extension on ReceiverStatus {
  bool get isFailure => this == ReceiverStatus.failure;
}
