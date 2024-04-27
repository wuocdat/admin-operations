import 'package:flutter/material.dart';

enum FetchDataStatus { initial, loading, success, failure }

extension FetchDataStatusX on FetchDataStatus {
  bool get isFailure => this == FetchDataStatus.failure;
  bool get isLoading => this == FetchDataStatus.loading;
  bool get isSuccess => this == FetchDataStatus.success;
}

enum TaskTypeE { report, investigate, monitor, other }

extension TaskTypeEX on TaskTypeE {
  bool get isReport => this == TaskTypeE.report;

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

enum ERole { superadmin, admin, mod, member }

extension ERoleX on ERole {
  String get name {
    switch (this) {
      case ERole.superadmin:
        return 'Super Admin';
      case ERole.admin:
        return 'Admin';
      case ERole.mod:
        return 'Quản lý';
      case ERole.member:
        return 'Thành viên';
    }
  }

  String get id {
    switch (this) {
      case ERole.superadmin:
        return '0';
      case ERole.admin:
        return '1';
      case ERole.mod:
        return '2';
      case ERole.member:
        return '3';
    }
  }
}

enum ENotificationType { mission, mail, chat }

extension ENotificationTypeX on ENotificationType {
  String get title {
    switch (this) {
      case ENotificationType.mission:
        return 'Nhiệm vụ';
      case ENotificationType.mail:
        return 'Mail';
      case ENotificationType.chat:
        return 'Tin nhắn';
    }
  }

  String get id {
    switch (this) {
      case ENotificationType.mission:
        return '1';
      case ENotificationType.mail:
        return '2';
      case ENotificationType.chat:
        return '3';
    }
  }
}
