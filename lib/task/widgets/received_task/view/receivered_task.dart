import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/received_task_detail/view/received_task_detail_page.dart';
import 'package:tctt_mobile/task/bloc/task_bloc.dart';
import 'package:tctt_mobile/task/widgets/received_task/bloc/receiver_bloc.dart';
import 'package:tctt_mobile/widgets/bottom_loader.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/msg_item.dart';
import 'package:tctt_mobile/widgets/toggle_options.dart';

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
                      if (state.tasks.isEmpty) {
                        return const EmptyListMessage(
                          message: "Không có nhiệm vụ nào",
                        );
                      }
                      return const TasksView();
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

class TasksView extends StatefulWidget {
  const TasksView({
    super.key,
  });

  @override
  State<TasksView> createState() => _TasksViewState();
}

class _TasksViewState extends State<TasksView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ReceiverBloc>().add(const ReceiverFetchedEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceiverBloc, ReceiverState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return index >= state.tasks.length
                ? const BottomLoader()
                : MessageItem(
                    name: state.tasks[index].unitSent.name,
                    time: state.tasks[index].createdAt,
                    title: state.tasks[index].name,
                    content: state.tasks[index].content,
                    isImportant: state.tasks[index].important,
                    onTap: () {
                      Navigator.of(context).push(
                        ReceivedTaskDetailPage.route(state.tasks[index].id),
                      );
                    },
                  );
          },
          itemCount:
              state.hasReachedMax ? state.tasks.length : state.tasks.length + 1,
          controller: _scrollController,
          padding: const EdgeInsetsDirectional.only(
            start: 12,
            end: 12,
            bottom: 8,
          ),
        );
      },
    );
  }
}

extension on ReceiverStatus {
  bool get isFailure => this == ReceiverStatus.failure;
  bool get isLoading => this == ReceiverStatus.loading;
}
