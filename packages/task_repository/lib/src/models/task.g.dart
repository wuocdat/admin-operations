// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      important: json['important'] as bool,
      content: json['content'] as String,
      units: Task._fromJson(json['units'] as List),
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      name: json['name'] as String,
      createdBy: json['createdBy'] as String,
      createdAt: json['createdAt'] as String,
      disable: json['disable'] as bool,
      unitSent: Unit.fromJson(json['unitSent'] as Map<String, dynamic>),
      type: TaskType.fromJson(json['type'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'important': instance.important,
      'content': instance.content,
      'units': instance.units,
      'files': instance.files,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'disable': instance.disable,
      'unitSent': instance.unitSent,
      'type': instance.type,
    };
