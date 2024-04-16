// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Progress _$ProgressFromJson(Map<String, dynamic> json) => Progress(
      id: json['_id'] as String,
      isActive: json['isActive'] as bool,
      content: json['content'] as String,
      unit: json['unit'] as String,
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      createdBy: json['createdBy'] as String,
      createdAt: json['createdAt'] as String,
      repeat: json['repeat'] as int,
      status: Map<String, String>.from(json['status'] as Map),
      task: json['task'] as String,
      total: json['total'] as int?,
    );

Map<String, dynamic> _$ProgressToJson(Progress instance) => <String, dynamic>{
      '_id': instance.id,
      'isActive': instance.isActive,
      'content': instance.content,
      'unit': instance.unit,
      'files': instance.files,
      'createdBy': instance.createdBy,
      'createdAt': instance.createdAt,
      'repeat': instance.repeat,
      'status': instance.status,
      'task': instance.task,
      'total': instance.total,
    };
