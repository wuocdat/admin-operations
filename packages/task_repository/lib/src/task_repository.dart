import 'package:api_client/api_client.dart';
import 'package:task_repository/src/models/models.dart';

const taskLimit = 5;

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

  Future<List<Task>> fetchReceivedTasks(String progressStatus,
      [int taskLength = 0]) async {
    final tasks = await _taskApiClient.getReceivedTasks(
        progressStatus, taskLimit, (taskLength / taskLimit).ceil() + 1);

    return tasks
        .map(
          (task) => Task(
            id: task.id,
            isActive: task.isActive,
            important: task.important,
            content: task.content,
            units: task.units,
            name: task.name,
            createdBy: task.createdBy,
            createdAt: task.createdAt,
            disable: task.disable,
            unitSent: Unit(
              id: task.unitSent.id,
              name: task.unitSent.name,
              createdBy: task.unitSent.createdBy,
              createdAt: task.unitSent.createdAt,
              isActive: task.unitSent.isActive,
            ),
            type: TaskType(
              id: task.type.id,
              isActive: task.type.isActive,
              name: task.type.name,
            ),
          ),
        )
        .toList();
  }
}
