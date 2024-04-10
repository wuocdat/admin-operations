// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Role _$RoleFromJson(Map<String, dynamic> json) => Role(
      id: json['_id'] as String,
      name: json['name'] as String,
      managed:
          (json['managed'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RoleToJson(Role instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'managed': instance.managed,
    };
