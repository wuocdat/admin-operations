// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Permission _$PermissionFromJson(Map<String, dynamic> json) => Permission(
      create: json['create'] as bool,
      update: json['update'] as bool,
      delete: json['delete'] as bool,
      read: json['read'] as bool,
    );

Map<String, dynamic> _$PermissionToJson(Permission instance) =>
    <String, dynamic>{
      'create': instance.create,
      'update': instance.update,
      'delete': instance.delete,
      'read': instance.read,
    };
