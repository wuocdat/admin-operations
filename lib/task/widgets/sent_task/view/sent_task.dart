import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/sent_task_detail/view/sent_task_detail_page.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/task/bloc/task_bloc.dart';
import 'package:tctt_mobile/task/widgets/sent_task/bloc/sender_bloc.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/msg_item.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';
import 'package:tctt_mobile/widgets/tags.dart';
import 'package:tctt_mobile/widgets/toggle_options.dart';

class SentTasks extends StatelessWidget {
  const SentTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SenderBloc(repository: RepositoryProvider.of<TaskRepository>(context))
            ..add(const SenderFetchedEvent()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SenderBloc, SenderState>(
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
                  .read<SenderBloc>()
                  .add(SearchInputChangedEvent(state.searchValue));
            },
          ),
          BlocListener<TaskBloc, TaskState>(
            listenWhen: (previous, current) =>
                previous.reloadCount != current.reloadCount,
            listener: (context, state) {
              context.read<SenderBloc>().add(const SentTaskRefetched());
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<SenderBloc, SenderState>(
              buildWhen: (previous, current) => previous.owner != current.owner,
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: ToggleOptions(
                      selectedIndex: state.owner.index,
                      items: Owner.values.map((e) => Text(e.title)).toList(),
                      onPressed: (int index) {
                        context
                            .read<SenderBloc>()
                            .add(OwnerChangedEvent(Owner.values[index]));
                      },
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<SenderBloc, SenderState>(
                builder: (context, state) {
                  switch (state.status) {
                    case FetchDataStatus.initial:
                      return const Loader();
                    default:
                      if (state.status.isLoading && state.tasks.isEmpty) {
                        return const Loader();
                      }
                      if (state.tasks.isEmpty) {
                        return const EmptyListMessage(
                          message: "Không có nhiệm vụ nào",
                        );
                      }
                      return RichListView(
                          hasReachedMax: state.hasReachedMax,
                          itemCount: state.tasks.length,
                          itemBuilder: (index) => MessageItem(
                                name: state.tasks[index].unitSent.name,
                                time: state.tasks[index].createdAt,
                                title: state.tasks[index].name,
                                content: state.tasks[index].content,
                                isImportant: state.tasks[index].important,
                                tag: SimpleTag(
                                  text: state.tasks[index].type.name,
                                  color:
                                      state.tasks[index].type.toTaskTypeE.color,
                                ),
                                onTap: () async {
                                  final needToReload =
                                      await Navigator.of(context).push(
                                    SentTaskDetailPage.route(
                                        state.tasks[index].id),
                                  );
                                  if (!context.mounted ||
                                      needToReload != true) {
                                    return;
                                  }
                                  context
                                      .read<SenderBloc>()
                                      .add(const SentTaskRefetched());
                                },
                              ),
                          onReachedEnd: () {
                            context
                                .read<SenderBloc>()
                                .add(const SenderFetchedEvent());
                          });
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
