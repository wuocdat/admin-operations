import 'dart:async';

import 'package:api_client/api_client.dart';
import 'package:task_repository/src/models/models.dart';

const taskLimit = 20;
const progressLimit = 20;

class TaskRepository {
  TaskRepository({TaskApiClient? taskApiClient})
      : _taskApiClient = taskApiClient ?? TaskApiClient();

  final TaskApiClient _taskApiClient;
  final _controller = StreamController<Overall>();

  Stream<Overall> get overall async* {
    final overall = await _taskApiClient.getOverall();

    yield Overall.fromJson(overall);

    yield* _controller.stream.asBroadcastStream();
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

  Future<List<ProgressDetail>> fetchTaskProgresses(String taskId, String unitId,
      [int length = 0]) async {
    final progresses = await _taskApiClient.fetchProgresses(
        taskId, unitId, progressLimit, (length / progressLimit).ceil() + 1);

    return progresses
        .map((e) => ProgressDetail.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> sentTask(
    String name,
    String type,
    List<String> units,
    String content,
    bool important,
    List<String> filePaths,
  ) async {
    await _taskApiClient.createTask(
      name,
      type,
      units,
      content,
      important,
      filePaths,
    );
  }

  Future<Task> fetchSentTaskById(String id) async {
    final taskJson = await _taskApiClient.fetchSentTaskById(id);

    return Task.fromJson(taskJson);
  }

  Future<Task> fetchReceivedTaskById(String id) async {
    final taskJson = await _taskApiClient.fetchReceivedTaskById(id);
    final overall = await _taskApiClient.getOverall();
    _controller.add(Overall.fromJson(overall));

    return Task.fromJson(taskJson);
  }

  Future<void> withDrawTask(String taskId) async {
    await _taskApiClient.updateSentTask(taskId, {
      "disable": true,
    });
  }

  Future<void> downloadFile(String url, String path,
      void Function(int, int) onReceiveProgress) async {
    await _taskApiClient.downloadFile(url, path, onReceiveProgress);
  }

  Future<void> reportTaskProgress(String taskProgressId, String content,
      int? times, List<String> filePaths) async {
    await _taskApiClient.updateTaskProgress(
        taskProgressId, content, times, filePaths);
  }

  Future<Statistic?> fetchStatistic(String taskId) async {
    final statisticJson = await _taskApiClient.fetchResultStatistic(taskId);

    if (statisticJson == null) return null;

    return Statistic.fromJson(statisticJson);
  }
}
