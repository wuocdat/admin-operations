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
          isActive: $checkedConvert('is_active', (v) => v as bool),
          important: $checkedConvert('important', (v) => v as bool),
          content: $checkedConvert('content', (v) => v as String),
          units: $checkedConvert('units',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          name: $checkedConvert('name', (v) => v as String),
          createdBy: $checkedConvert('created_by', (v) => v as String),
          createdAt:
              $checkedConvert('created_at', (v) => DateTime.parse(v as String)),
          disable: $checkedConvert('disable', (v) => v as bool),
          unitSent: $checkedConvert(
              'unit_sent', (v) => Unit.fromJson(v as Map<String, dynamic>)),
          type: $checkedConvert(
              'type', (v) => TaskType.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'id': '_id',
        'isActive': 'is_active',
        'createdBy': 'created_by',
        'createdAt': 'created_at',
        'unitSent': 'unit_sent'
      },
    );
