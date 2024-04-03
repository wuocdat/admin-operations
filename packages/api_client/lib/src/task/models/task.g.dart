// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Task',
      json,
      ($checkedConvert) {
        final val = Task(
          id: $checkedConvert('_id', (v) => v as String),
          important: $checkedConvert('important', (v) => v as bool),
          content: $checkedConvert('content', (v) => v as String),
          units: $checkedConvert('units',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          name: $checkedConvert('name', (v) => v as String),
          createdBy: $checkedConvert('createdBy', (v) => v as String),
          createdAt: $checkedConvert('createdAt', (v) => v as String),
          disable: $checkedConvert('disable', (v) => v as bool),
          unitSent: $checkedConvert(
              'unitSent', (v) => Unit.fromJson(v as Map<String, dynamic>)),
          isActive: $checkedConvert('isActive', (v) => v as bool),
          type: $checkedConvert(
              'type', (v) => TaskType.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'id': '_id'},
    );
