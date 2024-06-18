import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/features/sent_task_detail/cubit/sent_task_detail_cubit.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/widgets/attachment/attachment.dart';
import 'package:tctt_mobile/shared/widgets/border_container.dart';
import 'package:tctt_mobile/shared/widgets/content_container.dart';
import 'package:tctt_mobile/shared/widgets/empty_list_message.dart';
import 'package:tctt_mobile/shared/widgets/label_text.dart';
import 'package:tctt_mobile/shared/widgets/loader.dart';
import 'package:tctt_mobile/shared/widgets/rich_list_view.dart';

class StatisticTree extends StatelessWidget {
  const StatisticTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentTaskDetailCubit, SentTaskDetailState>(
      buildWhen: (previous, current) =>
          previous.statistic != current.statistic ||
          previous.status != current.status,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const MediumLabelText("Thống kê"),
            const SizedBox(height: 8),
            if (state.statistic == null && !state.status.isLoading)
              const Text(
                'Chưa có báo cáo nào',
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            else
              BorderContainer(
                height: 300,
                child: state.status.isLoading
                    ? const Loader()
                    : TreeView.simpleTyped<Statistic, TreeNode<Statistic>>(
                        tree: state.statistic?.toTreeData ?? TreeNode.root(),
                        builder: (_, node) {
                          final titles = node.data?.name.split("-");

                          return titles != null
                              ? ListTile(
                                  title: Text(titles.first),
                                  subtitle: Text(titles.last),
                                  onTap: () => {
                                    context
                                        .read<SentTaskDetailCubit>()
                                        .changeUnit(node.data?.id ?? ""),
                                    showDialog<String>(
                                      context: context,
                                      builder: (_) =>
                                          MemberProgressOfSelectedUnitList(
                                        context.read<SentTaskDetailCubit>(),
                                        unitId: node.data?.id ?? "",
                                      ),
                                    ),
                                  },
                                )
                              : const SizedBox();
                        },
                      ),
              ),
          ],
        );
      },
    );
  }
}

class MemberProgressOfSelectedUnitList extends StatelessWidget {
  const MemberProgressOfSelectedUnitList(
    this.sentTaskDetailCubit, {
    super.key,
    required this.unitId,
  });

  final SentTaskDetailCubit sentTaskDetailCubit;
  final String unitId;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: sentTaskDetailCubit,
      child: AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Danh sách báo cáo'),
        content: Container(
          width: screenSize.width * 0.8,
          padding: const EdgeInsets.only(bottom: 10, top: 40),
          child: BlocBuilder<SentTaskDetailCubit, SentTaskDetailState>(
            builder: (context, state) {
              switch (state.status) {
                case FetchDataStatus.initial:
                  return const Loader();
                default:
                  if (state.status.isLoading && state.progresses.isEmpty) {
                    return const Loader();
                  }
                  if (state.progresses.isEmpty) {
                    return const SizedBox(
                      height: 300,
                      child: EmptyListMessage(
                        message: "Chưa có báo cáo nào",
                      ),
                    );
                  }
                  return RichListView(
                    hasReachedMax: state.hasReachedMax,
                    itemCount: state.progresses.length,
                    itemBuilder: (index) {
                      final currentProgress = state.progresses[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: Colors.grey.withOpacity(0.3)),
                          ),
                        ),
                        child: Column(
                          children: [
                            ContentContainer(
                              sender: currentProgress.createdBy['name'] ?? "",
                              title: currentProgress.content,
                              content: state.currentTask.content,
                              time: currentProgress.createdAt,
                              actions: const [],
                            ),
                            if (currentProgress.files.isNotEmpty)
                              Attachment(
                                filePaths: currentProgress.files,
                                withoutTitle: true,
                              ),
                          ],
                        ),
                      );
                    },
                    onReachedEnd: () {
                      context
                          .read<SentTaskDetailCubit>()
                          .fetchProgresses(state.currentTask.id, unitId);
                    },
                  );
              }
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

extension on Statistic {
  TreeNode<Statistic> get toTreeData {
    return TreeNode.root(
      data: this,
    )..addAll(children?.map((e) => e._toTreeData) ?? []);
  }

  TreeNode<Statistic> get _toTreeData {
    return TreeNode(
      key: id,
      data: this,
    )..addAll(children?.map((e) => e._toTreeData) ?? []);
  }
}
