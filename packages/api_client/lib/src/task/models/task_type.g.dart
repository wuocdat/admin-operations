// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'TaskType',
      json,
      ($checkedConvert) {
        final val = TaskType(
          id: $checkedConvert('_id', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          isActive: $checkedConvert('is_active', (v) => v as bool),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id', 'isActive': 'is_active'},
    );
