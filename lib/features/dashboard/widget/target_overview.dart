import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tctt_mobile/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:tctt_mobile/features/dashboard/widget/overview.dart';
import 'package:tctt_mobile/features/dashboard/widget/target_chart.dart';

class TargetOverview extends StatelessWidget {
  const TargetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Overview(
      title: 'Hoạt động của các đối tượng',
      subtitle:
      'Đồ thị biểu diễn số bài đăng của các đối tượng những ngày gần đây',
      child: AspectRatio(
        aspectRatio: 1.5,
        child: BlocBuilder<DashboardBloc, DashboardState>(
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(height: 32),
                Expanded(child: TargetChart(postData: state.postData)),
              ],
            );
          },
        ),
      ),
    );
  }
}
