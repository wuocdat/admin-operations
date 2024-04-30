// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mail _$MailFromJson(Map<String, dynamic> json) => Mail(
      content: json['content'] as String,
      createdAt: json['createdAt'] as String,
      createdBy: json['createdBy'] as Map<String, dynamic>,
      files: (json['files'] as List<dynamic>).map((e) => e as String).toList(),
      important: json['important'] as bool,
      id: json['_id'] as String,
      name: json['name'] as String,
      read: json['read'] as bool,
      updatedAt: json['updatedAt'] as String,
      updatedBy: json['updatedBy'] as String,
    );

Map<String, dynamic> _$MailToJson(Mail instance) => <String, dynamic>{
      'content': instance.content,
      'createdAt': instance.createdAt,
      'createdBy': instance.createdBy,
      'files': instance.files,
      'important': instance.important,
      '_id': instance.id,
      'name': instance.name,
      'read': instance.read,
      'updatedAt': instance.updatedAt,
      'updatedBy': instance.updatedBy,
    };
