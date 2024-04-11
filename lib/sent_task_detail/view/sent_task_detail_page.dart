import 'package:flutter/material.dart';

class SentTaskDetailPage extends StatelessWidget {
  const SentTaskDetailPage({super.key, required this.taskId});

  static Route<void> route(String taskId) {
    return MaterialPageRoute<void>(
      builder: (_) => SentTaskDetailPage(taskId: taskId),
    );
  }

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Nhiệm vụ',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Urbanist',
                letterSpacing: 0,
              ),
        ),
      ),
      body: Center(
        child: Text('Task ID: $taskId'),
      ),
    );
  }
}
