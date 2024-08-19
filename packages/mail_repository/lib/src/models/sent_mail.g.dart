// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sent_mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SentMailType _$SentMailTypeFromJson(Map<String, dynamic> json) => SentMailType(
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as String,
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      important: json['important'] as bool,
      id: json['_id'] as String,
      name: json['name'] as String,
      updatedAt: json['updatedAt'] as String,
      updatedBy: json['updatedBy'] as String,
      receivers: (json['receivers'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$SentMailTypeToJson(SentMailType instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'files': instance.files,
      'important': instance.important,
      '_id': instance.id,
      'name': instance.name,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
      'receivers': instance.receivers,
    };
