import 'package:flutter/material.dart';

enum FetchDataStatus { initial, loading, success, failure }

extension FetchDataStatusX on FetchDataStatus {
  bool get isFailure => this == FetchDataStatus.failure;
  bool get isLoading => this == FetchDataStatus.loading;
  bool get isSuccess => this == FetchDataStatus.success;
}

enum TaskTypeE { report, investigate, monitor, other }

extension TaskTypeEX on TaskTypeE {
  String get name {
    switch (this) {
      case TaskTypeE.report:
        return 'Báo xấu';
      case TaskTypeE.investigate:
        return 'Điều tra';
      case TaskTypeE.monitor:
        return 'Giám sát';
      case TaskTypeE.other:
        return 'Khác';
    }
  }

  String get id {
    switch (this) {
      case TaskTypeE.report:
        return '1';
      case TaskTypeE.investigate:
        return '2';
      case TaskTypeE.monitor:
        return '3';
      case TaskTypeE.other:
        return '0';
    }
  }

  Color get color {
    switch (this) {
      case TaskTypeE.report:
        return Colors.red;
      case TaskTypeE.investigate:
        return Colors.orange;
      case TaskTypeE.monitor:
        return Colors.green;
      case TaskTypeE.other:
        return Colors.blue;
    }
  }
}
