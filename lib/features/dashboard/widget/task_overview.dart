import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/features/dashboard/widget/info_item.dart';
import 'package:tctt_mobile/features/dashboard/widget/overview.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Overview(
          title: 'Nhiệm vụ',
          subtitle: 'Nhiệm vụ nhận trong ngày',
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InfoItem(
                  value: '${state.task.finished}/${state.task.all}',
                  title: 'Đã báo cáo',
                ),
                InfoItem(
                  value: '${state.task.unfinished}',
                  title: 'Đang thực hiện',
                ),
                InfoItem(
                  value: '${state.task.unread}',
                  title: 'Chưa đọc',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
