import 'package:flutter/material.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/widgets/attachment/attachment.dart';

class ReportDetail extends StatelessWidget {
  final Progress _progress;
  final void Function() _onReportAgain;
  final List<String> _attachments;

  const ReportDetail({
    super.key,
    required Progress progress,
    required void Function() onReportAgain,
    required List<String> attachments,
  })  : _progress = progress,
        _onReportAgain = onReportAgain,
        _attachments = attachments;

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
              onPressed: _progress.repeat < 3 ? _onReportAgain : null,
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
        if (_progress.total != null)
          Text(
            'Số lượt: ${_progress.total}',
            style: const TextStyle(fontSize: 14),
          ),
        if (_attachments.isNotEmpty)
          Attachment(
            filePaths: _attachments,
            withoutTitle: true,
          ),
      ],
    );
  }
}
