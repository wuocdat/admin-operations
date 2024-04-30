import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/dashboard/widget/info_item.dart';
import 'package:tctt_mobile/widgets/shadow_box.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return ShadowBox(
            child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nhiệm Vụ',
                      style: textTheme.headlineSmall,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        'Nhiệm vụ nhận trong ngày',
                        style: textTheme.labelMedium,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.keyboard_arrow_right_rounded,
                  size: 24,
                ),
              ],
            ),
            Row(
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
          ],
        ));
      },
    );
  }
}
