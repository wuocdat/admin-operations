import 'package:conversation_repository/conversation_repository.dart';
import 'package:task_repository/task_repository.dart';
import 'package:tctt_mobile/shared/enums.dart';
import 'package:user_repository/user_repository.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String? get noBlank {
    if (isEmpty) {
      return null;
    }
    return this;
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

extension UserX on User {
  ERole get roleE {
    switch (role) {
      case '0':
        return ERole.superadmin;
      case '1':
        return ERole.admin;
      case '2':
        return ERole.mod;
    }
    return ERole.member;
  }

  bool hasPermission(List<ERole> roles) {
    return roles.contains(roleE);
  }
}

extension ConversationX on Conversation {
  String getName(String currentUserId) {
    if (conversationUsers.length > 2) {
      return name ??
          conversationUsers.map((e) => e.userDetail['name']).join(", ");
    } else {
      return currentUserId == conversationUsers[0].userId
          ? conversationUsers[1].userDetail['name']!
          : conversationUsers[0].userDetail['name']!;
    }
  }
}
