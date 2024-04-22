import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension TaskTypeExtension on TaskType {
  TaskTypeE get toTaskTypeE {
    switch (id) {
      case "1":
        return TaskTypeE.report;
      case "2":
        return TaskTypeE.investigate;
      case "3":
        return TaskTypeE.monitor;
    }

    return TaskTypeE.other;
  }
}
