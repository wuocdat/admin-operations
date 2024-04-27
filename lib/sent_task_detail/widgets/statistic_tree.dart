import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/sent_task_detail/cubit/sent_task_detail_cubit.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:tctt_mobile/shared/utils/extensions.dart';
import 'package:tctt_mobile/widgets/border_container.dart';
import 'package:tctt_mobile/widgets/content_container.dart';
import 'package:tctt_mobile/widgets/empty_list_message.dart';
import 'package:tctt_mobile/widgets/label_text.dart';
import 'package:tctt_mobile/widgets/loader.dart';
import 'package:tctt_mobile/widgets/rich_list_view.dart';
import 'package:tctt_mobile/widgets/tags.dart';

class StatisticTree extends StatelessWidget {
  const StatisticTree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SentTaskDetailCubit, SentTaskDetailState>(
      buildWhen: (previous, current) => previous.statistic != current.statistic,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const MediumLabelText("Thống kê"),
            const SizedBox(height: 8),
            BorderContainer(
              height: 300,
              child: state.status == FetchDataStatus.loading
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
                                    })
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Danh sách báo cáo'),
        content: Container(
          width: screenSize.width * 0.8,
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 40),
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
                        message: "Không có báo cáo nào",
                      ),
                    );
                  }
                  return RichListView(
                    hasReachedMax: state.hasReachedMax,
                    itemCount: state.progresses.length,
                    itemBuilder: (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: ContentContainer(
                        sender: state.progresses[index].content,
                        title: state.progresses[index].content,
                        content: state.currentTask.content,
                        time: state.progresses[index].createdAt,
                        actions: [
                          SimpleTag(
                            text: state.currentTask.type.name,
                            color: state.currentTask.type.toTaskTypeE.color,
                          ),
                        ],
                      ),
                    ),
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
