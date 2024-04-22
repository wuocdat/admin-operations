// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) => TaskType(
      id: json['_id'] as String,
      name: json['name'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$TaskTypeToJson(TaskType instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'isActive': instance.isActive,
    };
