import 'package:flutter/material.dart';
import 'package:tctt_mobile/features/dashboard/widget/overview.dart';
import 'package:tctt_mobile/features/dashboard/widget/target_chart.dart';

class TargetOverview extends StatelessWidget {
  const TargetOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Overview(
      title: 'Hoạt động của các đối tượng',
      subtitle:
          'Đồ thị biểu diễn số bài đăng của các đối tượng những ngày gần đây',
      child: AspectRatio(
        aspectRatio: 1.6,
        child: TargetChart(),
      ),
    );
  }
}
