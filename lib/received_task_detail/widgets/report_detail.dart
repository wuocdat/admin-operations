import 'package:flutter/material.dart';

class ReportDetail extends StatelessWidget {
  final String reportContent;
  final int times;
  final String time;

  const ReportDetail({
    super.key,
    required this.reportContent,
    required this.times,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          minVerticalPadding: 0,
          leading: Icon(
            Icons.check_circle,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            'Đã báo cáo',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Text(reportContent),
        Text(
          'Vào lúc: $time',
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          'Số lượt: $times',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
