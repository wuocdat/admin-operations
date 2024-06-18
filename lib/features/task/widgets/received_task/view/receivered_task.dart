import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/features/received_task_detail/view/received_task_detail_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/core/utils/extensions.dart';
import 'package:tctt_mobile/features/task/bloc/task_bloc.dart';
import 'package:tctt_mobile/features/task/widgets/received_task/bloc/receiver_bloc.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/msg_item.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';
import 'package:tctt_mobile/shared/widgets/tags.dart';
import 'package:tctt_mobile/shared/widgets/toggle_options.dart';

class ReceivedTasks extends StatelessWidget {
  const ReceivedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReceiverBloc(
          repository: RepositoryProvider.of<TaskRepository>(context))
        ..add(const ReceiverFetchedEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<ReceiverBloc, ReceiverState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(content: Text("Đã xảy ra lỗi")),
                  );
              }
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listenWhen: (previous, current) =>
                previous.searchValue != current.searchValue,
            listener: (context, state) {
              context
                  .read<ReceiverBloc>()
                  .add(SearchInputChangedEvent(state.searchValue));
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<ReceiverBloc, ReceiverState>(
              buildWhen: (previous, current) =>
                  previous.progressStatus != current.progressStatus,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: ToggleOptions(
                      selectedIndex: state.progressStatus.index,
                      items: TaskProgressStatus.values
                          .map((e) => Text(e.title))
                          .toList(),
                      onPressed: (int index) {
                        context
                            .read<ReceiverBloc>()
                            .add(ProgressStatusChangedEvent(
                              TaskProgressStatus.values[index],
                            ));
                      },
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<ReceiverBloc, ReceiverState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ReceiverStatus.initial:
                      return const Loader();
                    default:
                      if (state.status.isLoading && state.tasks.isEmpty) {
                        return const Loader();
                      }
                      return RichListView(
                        onRefresh: () async {
                          context
                              .read<ReceiverBloc>()
                              .add(const ReceiverResetEvent());
                        },
                        physics: const AlwaysScrollableScrollPhysics(),
                        hasReachedMax: state.hasReachedMax,
                        itemCount: state.tasks.length,
                        itemBuilder: (index) {
                          final currentTask = state.tasks[index];
                          return currentTask.disable
                              ? Container()
                              : MessageItem(
                                  name: currentTask.unitSent.name,
                                  time: currentTask.createdAt,
                                  title: currentTask.name,
                                  content: currentTask.content,
                                  isImportant: currentTask.important,
                                  highlighted: currentTask.progress == null,
                                  tag: SimpleTag(
                                    text: currentTask.type.name,
                                    color: currentTask.type.toTaskTypeE.color,
                                  ),
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                      ReceivedTaskDetailPage.route(
                                          currentTask.id),
                                    );
                                    if (!context.mounted) return;
                                    context
                                        .read<ReceiverBloc>()
                                        .add(const ReceiverResetEvent());
                                  },
                                );
                        },
                        onReachedEnd: () {
                          context
                              .read<ReceiverBloc>()
                              .add(const ReceiverFetchedEvent());
                        },
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
  bool get isLoading => this == ReceiverStatus.loading;
}
