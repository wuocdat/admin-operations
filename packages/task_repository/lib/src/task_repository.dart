import 'package:api_client/api_client.dart';
import 'package:task_repository/src/models/models.dart';

const taskLimit = 5;

class TaskRepository {
  TaskRepository({TaskApiClient? taskApiClient})
      : _taskApiClient = taskApiClient ?? TaskApiClient();

  final TaskApiClient _taskApiClient;

  Future<Overall> getOverall() async {
    final overall = await _taskApiClient.getOverall();

    return Overall.fromJson(overall);
  }

  Future<List<Task>> fetchReceivedTasks(
      String progressStatus, String? searchValue,
      [int taskLength = 0]) async {
    final tasks = await _taskApiClient.getReceivedTasks(
      progressStatus,
      searchValue,
      taskLimit,
      (taskLength / taskLimit).ceil() + 1,
    );

    return tasks.map((e) => Task.fromJson(e)).toList();
  }

  Future<List<Task>> fetchSentTasks(String owner, String? searchValue,
      [int taskLength = 0]) async {
    final tasks = await _taskApiClient.getSentTasks(
        owner, searchValue, taskLimit, (taskLength / taskLimit).ceil() + 1);

    return tasks.map((e) => Task.fromJson(e)).toList();
  }
}
