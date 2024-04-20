import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';

class ReportDetail extends StatelessWidget {
  final Progress _progress;

  const ReportDetail({
    super.key,
    required Progress progress,
  }) : _progress = progress;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: ListTile(
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
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _progress.repeat <= 3 ? () {} : null,
              style: TextButton.styleFrom(
                foregroundColor: primaryColor,
              ),
              child: Text('Báo lại ${_progress.repeat}/3'),
            ),
          ],
        ),
        Text(_progress.content),
        Text(
          'Lúc: ${_progress.createdAt}',
          style: const TextStyle(fontSize: 14),
        ),
        Text(
          'Số lượt: ${_progress.total}',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
