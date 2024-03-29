import 'package:api_client/api_client.dart';
import 'package:task_repository/src/models/models.dart';

class TaskRepository {
  TaskRepository({TaskApiClient? taskApiClient})
      : _taskApiClient = taskApiClient ?? TaskApiClient();

  final TaskApiClient _taskApiClient;

  Future<Overall> getOverall() async {
    final overall = await _taskApiClient.getOverall();

    return Overall(
      all: overall.all,
      finished: overall.finished,
      unfinished: overall.unfinished,
      unread: overall.unread,
    );
  }
}
